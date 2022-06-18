from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker, declarative_base

# Async AwaitのURL
ASYNC_DB_URL = "mysql+aiomysql://root@fast-api-db:3306/demo?charset=utf8mb4"

async_engine = create_async_engine(ASYNC_DB_URL, echo=True)
async_session = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=async_engine,
    class_=AsyncSession
)

Base = declarative_base()


# セッションを取得しDBアクセス可能とする
async def get_db():
    async with async_session() as session:
        yield session
