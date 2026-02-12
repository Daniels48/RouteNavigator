from datetime import timedelta, datetime, time
from geopy.distance import geodesic


def generate_schedule(start_time: time, end_time: time, interval_minutes: int):
    schedule = []
    current = datetime.combine(datetime.today(), start_time)
    end = datetime.combine(datetime.today(), end_time)

    while current <= end:
        schedule.append(current.time())
        current += timedelta(minutes=interval_minutes)

    return schedule


def get_meters_both_coordinates(from_, to_):
    return geodesic(from_, to_).meters # lat,lon