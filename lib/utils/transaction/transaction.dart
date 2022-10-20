double getTime() {
    final dateStart = DateTime.utc(1970, 1, 1);
    final dateNow = DateTime.now().toUtc();
    final difference = dateNow.difference(dateStart);
    final d = difference.inMilliseconds;

    return d.truncate().toDouble();
  }