### 参考资料







```python
import os
from datetime import timedelta

from celery import Celery
from celery.schedules import crontab

if not os.getenv("DJANGO_SETTINGS_MODULE"):
    os.environ["DJANGO_SETTINGS_MODULE"] = 'spic_backend.settings'

celery_app = Celery('spic', namespace="CELERY")

celery_app.config_from_object('spic_backend.settings')

celery_app.autodiscover_tasks(['apps.timed_task', ])


celery_app.conf.update(
    CELERY_SCHEDULE={
        # 定时任务1
        "task_1": {
            "task": "timed_task.tasks.process_timed_task",
            "schedule": timedelta(seconds=30),  # 每30秒执行某任务
            "args": (10, 11),
        },
        # 定时任务2：每天的凌晨12:30分，执行任务xx
        "task_2": {
            "task": "timed_task.tasks.process_timed_task",
            "schedule": crontab(hour=14, minute=35),  # 每48小时执行某任务
            "args": (20, 21),
        },
        # 定时任务3 : 每个月的1号的6:00 启动， 执行任务xx
        "task_3": {
            "task": "timed_task.tasks.process_timed_task",
            "schedule": crontab(hour=14, minute=38),  # 10:46执行某任务
            "args": (30, 31),
        },
        # 定时任务4
        "task_4": {
            "task": "timed_task.tasks.process_timed_task",
            "schedule": crontab(hour=14, minute=40),  # 每48小时执行某任务
            "args": (5, 5),
        }
    }
)
```

