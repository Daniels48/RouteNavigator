import time
import logging
import asyncio
from functools import wraps


def log_execution_time(func):
    if asyncio.iscoroutinefunction(func):

        @wraps(func)
        async def async_wrapper(*args, **kwargs):
            logger = logging.getLogger(func.__module__)
            start = time.perf_counter()
            try:
                result = await func(*args, **kwargs)
                return result
            except Exception:
                logger.exception("Error in async function '%s'", func.__name__)
                raise
            finally:
                duration = time.perf_counter() - start
                logger.info(
                    "Async function '%s' executed in %.4f seconds",
                    func.__name__,
                    duration,
                )

        return async_wrapper

    else:

        @wraps(func)
        def sync_wrapper(*args, **kwargs):
            logger = logging.getLogger(func.__module__)
            start = time.perf_counter()
            try:
                result = func(*args, **kwargs)
                return result
            except Exception:
                logger.exception("Error in function '%s'", func.__name__)
                raise
            finally:
                duration = time.perf_counter() - start
                logger.info(
                    "Function '%s' executed in %.4f seconds",
                    func.__name__,
                    duration,
                )

        return sync_wrapper
