from contextlib import asynccontextmanager

from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, ConfigDict
from sqlalchemy import create_engine, String, Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
from sqlalchemy.orm import sessionmaker, Session


# Database configuration
from config import DATABASE_URL, FRONTEND_URL

engine = create_engine(
    DATABASE_URL,
    connect_args={"check_same_thread": False}
)

SessionLocal = sessionmaker(
    bind=engine,
    autoflush=False,
    autocommit=False
)


# SQLAlchemy model
class Base(DeclarativeBase):
    pass


class Emp(Base):
    __tablename__ = "emp"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    name: Mapped[str] = mapped_column(String(100), nullable=False)
    sal: Mapped[float] = mapped_column(Float, nullable=False)


# Create database table
@asynccontextmanager
async def lifespan(app: FastAPI):
    Base.metadata.create_all(bind=engine)
    yield


app = FastAPI(lifespan=lifespan)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[FRONTEND_URL],
    allow_methods=["*"],
    allow_headers=["*"],
)


# Database dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# Request/response schema
class EmpSchema(BaseModel):
    name: str
    sal: float


class EmpResponse(EmpSchema):
    id: int
    model_config = ConfigDict(from_attributes=True)


# GET /emps
@app.get("/emps", response_model=list[EmpResponse])
def get_emps(db: Session = Depends(get_db)):
    return db.query(Emp).order_by(Emp.id).all()


# POST /emps
@app.post("/emps", response_model=EmpResponse, status_code=201)
def add_emp(emp: EmpSchema, db: Session = Depends(get_db)):
    new_emp = Emp(name=emp.name, sal=emp.sal)

    db.add(new_emp)
    db.commit()
    db.refresh(new_emp)

    return new_emp
