# Docker Alpine Cron

## Basic Usage

### Backups

```bash
docker run -d \
    -e CRON_SOURCES="/var/tmp/backup_directory,/var/tmp/backup_volume" \
    -e CRON_NAMES="backup_directory,backup_volume" \
    -v /path/to/location/to/backup:/var/tmp/backup_directory, \
    -v volume_to_backup:/var/tmp/backup_volume, \
    -v /path/to/backup/storage:/backups \
    bmaximuml/alpine-cron:1.1
```

### Periodic Shell Scripts

```bash
docker run -d \
    -v do_something_daily.sh:/etc/periodic/daily/do_something.sh:ro
    -v do_something_hourly.sh:/etc/periodic/hourly/do_something.sh:ro
    -v do_something_weekly.sh:/etc/periodic/weekly/do_something.sh:ro
    -v do_something_monthly.sh:/etc/periodic/monthly/do_something.sh:ro
    -v do_something_15min.sh:/etc/periodic/15min/do_something.sh:ro
    bmaximuml/alpine-cron:1.1
```
### Periodic Python Scripts

```bash
docker run -d \
    -v do_something_daily.py:/etc/periodic/daily/do_something.py:ro
    -v do_something_hourly.py:/etc/periodic/hourly/do_something.py:ro
    -v do_something_weekly.py:/etc/periodic/weekly/do_something.py:ro
    -v do_something_monthly.py:/etc/periodic/monthly/do_something.py:ro
    -v do_something_15min.py:/etc/periodic/15min/do_something.py:ro
    bmaximuml/alpine-cron:1.1-python
```

## Description

Cron executes all files in the subdirectories of the */etc/periodic* directory.
These directories are:

- *15min*
- *hourly*
- *daily*
- *weekly*
- *monthtly*

Directories listed in `CRON_SOURCES` will be tar-ed up and stored in */backups* daily.
`CRON_SOURCES` and `CRON_NAMES` will be iterated over in parallel, tar-ing up the directory or file paths listed in `CRON_SOURCES` and placing the result in `/backups/$CRON_NAMES`.

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

