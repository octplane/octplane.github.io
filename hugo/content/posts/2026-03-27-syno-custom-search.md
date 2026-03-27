---
title: How to create a synology downloaad station search plugin
date: 2026-03-27
lang: en
---

# How to Create a Synology Download Station Search Plugin (.dlm)

A `.dlm` file is a **gzip-compressed tar archive** containing two files that Synology's Download Station uses to search torrent sites.

## Archive Structure

```
my_plugin.dlm (tar.gz)
├── INFO          # Plugin metadata (JSON)
└── search.php    # Search logic (PHP class)
```

## INFO File

A JSON file describing the plugin. Example:

```json
{
  "name": "my_plugin",
  "displayname": "My Torrent Site",
  "description": "Search torrents on example.com",
  "version": "1.0",
  "site": "https://example.com/",
  "module": "search.php",
  "type": "search",
  "class": "SynoDLMSearchMyPlugin"
}
```

### Fields

| Field            | Required | Description                                          |
|------------------|----------|------------------------------------------------------|
| `name`           | Yes      | Internal identifier (no spaces)                      |
| `displayname`    | Yes      | Name shown in Download Station UI                    |
| `description`    | Yes      | Short description                                    |
| `version`        | Yes      | Plugin version string                                |
| `site`           | Yes      | URL of the torrent site                              |
| `module`         | Yes      | PHP filename (always `search.php`)                   |
| `type`           | Yes      | Always `search`                                      |
| `class`          | Yes      | PHP class name — **must match exactly** in both files |
| `accountsupport` | No      | `true` if the site requires login (changes `prepare()` signature) |

## search.php

A PHP class implementing two required methods: `prepare()` and `parse()`.

### Method Signatures

The `prepare()` signature depends on `accountsupport` in INFO:

- **`accountsupport` is `false` or absent:**
  ```php
  public function prepare($curl, $query)
  ```
- **`accountsupport` is `true`:**
  ```php
  public function prepare($curl, $query, $username, $password)
  ```

**This is critical** — using the wrong signature causes a silent PHP fatal error and the plugin will not work.

### prepare($curl, $query)

Configure the cURL handle that Synology will execute. You set the URL, headers, and options here. You do **not** execute the request yourself.

```php
public function prepare($curl, $query) {
    $url = 'https://example.com/api/search?q=' . urlencode($query);

    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_HTTPHEADER, ['Authorization: Bearer MY_KEY']);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($curl, CURLOPT_TIMEOUT, 20);
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
}
```

### parse($plugin, $response)

Receives the raw HTTP response body (string). Parse it and call `$plugin->addResult()` for each torrent found. Return the number of results.

```php
public function parse($plugin, $response) {
    $json = json_decode($response, true);
    $res = 0;

    foreach ($json['results'] as $item) {
        $plugin->addResult(
            $title,      // string: torrent name
            $download,   // string: .torrent URL or magnet: link
            $size,       // int: size in bytes
            $datetime,   // string: date in "Y-m-d" format
            $page,       // string: URL to the torrent page
            $hash,       // string: unique identifier (infohash or md5 of title)
            $seeds,      // int: number of seeders
            $leechs,     // int: number of leechers
            $category    // string: category label
        );
        $res++;
    }

    return $res;
}
```

### addResult() Parameters

| #  | Name       | Type   | Description                                |
|----|------------|--------|--------------------------------------------|
| 1  | `title`    | string | Torrent display name                       |
| 2  | `download` | string | `.torrent` URL or `magnet:` URI            |
| 3  | `size`     | int    | File size in bytes                         |
| 4  | `datetime` | string | Upload date (`Y-m-d` format)               |
| 5  | `page`     | string | URL to the torrent detail page             |
| 6  | `hash`     | string | Unique ID (typically the infohash)         |
| 7  | `seeds`    | int    | Seeder count                               |
| 8  | `leechs`   | int    | Leecher count                              |
| 9  | `category` | string | Category label (e.g. `"Films: HD"`)        |

## Debugging

Add a debug logger to your class:

```php
private $debug = true;

private function DebugLog($str) {
    if ($this->debug) {
        file_put_contents('/tmp/my_plugin.log', $str . "\n", FILE_APPEND);
    }
}
```

Then SSH into the Synology and `tail -f /tmp/my_plugin.log` while running a search.

Set `$debug = false` for production.

## Building the .dlm

From the directory containing `INFO` and `search.php`:

```bash
tar czf my_plugin.dlm INFO search.php
```

## Installing

1. Open **Download Station** on your Synology
2. Go to **Settings > BT Search**
3. Click **Add** and upload the `.dlm` file
4. Enable the plugin with the checkbox

