# %% Import libraries
import os
import pretty_errors  # noqa: F401

from dotenv import find_dotenv, load_dotenv
from loguru import logger

# %% User Parameters
# find .env automagically by walking up directories until it's found, then
# load up the .env entries as environment variables
load_dotenv(find_dotenv())
API_KEY = os.getenv("API_KEY")


# %% Define main functions
def main():
    logger.info("====================================")
    logger.info("START the main script")

    # Load the data
    logger.info("Load the data")

    # Make the pre-processing
    logger.info("Make the pre-processing")

    # Train & Predict on your model
    logger.info("Train & Predict on your model")

    # Export the data
    logger.info("Export the data")

    logger.info("END the main script")
    logger.info("====================================")


if __name__ == "__main__":
    main()
