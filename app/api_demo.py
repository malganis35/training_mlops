import pretty_errors  # noqa: F401
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/predict")
async def predict(number: int):
    """
    Predict whether a number is odd or even.

    :param number: The number to predict.
    :return: A message indicating whether the number is odd or even.

    here is an example on how to use it: http://127.0.0.1:8601/predict?number=42
    """
    if number % 2 == 0:
        return {"result": "even"}
    else:
        return {"result": "odd"}
