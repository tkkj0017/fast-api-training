from typing import Optional

from pydantic import BaseModel, Field


class TaskBase(BaseModel):
    title: Optional[str]
    

class TaskCreate(TaskBase):
    pass


class TaskCreateResponse(TaskCreate):
    id: int

    class Config:
        orm_mode = True
        
        
class Task(BaseModel):
    id: int
    done: bool = Field(False, description="完了ランク")
    
    class Config:
        orm_mode = True
