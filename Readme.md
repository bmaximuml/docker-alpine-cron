# Docker Alpine Cron

## Basic Usage

```python
docker run -d \
    -e CRON_SOURCES="/var/tmp/backup_directory,/var/tmp/backup_volume" \
    -e CRON_NAMES="backup_directory,backup_volume" \
    -v /path/to/location/to/backup:/var/tmp/backup_directory, \
    -v volume_to_backup:/var/tmp/backup_volume, \
    -v /path/to/backup/storage:/backups \
    bmaximuml/alpine-cron:1.1
```

## Description

Iterates over `CRON_SOURCES` and `CRON_NAMES` in parallel, tar-ing up the directory or file paths listed in `CRON_SOURCES` and placing the result in `/backups/$CRON_NAMES`.

## Docker Compose

```yaml
version: '3.8'

services:
  cron:
    image: bmaximuml/alpine-cron:1.1
    environment:
      CRON_SOURCES: /var/tmp/backup_directory,/var/tmp/backup_volume
      CRON_NAMES: backup_directory,backup_volume
    volumes:
      - /path/to/location/to/backup:/var/tmp/backup_directory
      - volume_to_backup:/var/tmp/backup_volume
      - /path/to/backup/storage:/backups

volumes:
  - volume_to_backup:
```

## Environment Variables

- `CRON_SOURCES`: A comma separated list of source paths to tar up and copy to /backups.
- `CRON_NAMES`: A comma separated list of names for backup directories.

