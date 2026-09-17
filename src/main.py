from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

progress_items = [
    {"id": 1, "topic": "Git", "status": "completed"},
    {"id": 2, "topic": "Python", "status": "in_progress"},
    {"id": 3, "topic": "FastAPI", "status": "in_progress"},
]


class ProgressItem(BaseModel):
    id: int
    topic: str
    status: str


@app.get("/health")
def health_check():
    return {"status": "healthy"}


@app.get("/progress")
def get_progress():
    return {"progress": progress_items}


@app.get("/progress/{item_id}")
def get_progress_item(item_id: int):
    for item in progress_items:
        if item["id"] == item_id:
            return item
    return {"error": "Item not found"}
