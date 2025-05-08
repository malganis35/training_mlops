# %% Import libraries
import click
import pretty_errors  # noqa: F401
from loguru import logger

# %% Define utility and cli functions


def parse_labels(ctx, param, value):
    """
    Parses a string containing comma-separated labels.

    Args:
        ctx: The command-line context (used by Click)
        param: The associated parameter (used by Click)
        value (str): The string containing the labels

    Returns:
        list: A list of labels with leading and trailing whitespace removed
    """
    if not value:
        return []
    # Split the string chain by coma (,) and delete beginning and ending space
    return [label.strip() for label in value.split(",")]


@click.group()
def cli():
    pass


@click.command("hello_world", context_settings={"show_default": True})
@click.option("-d", "--dataset", default="Iris", help="Dataset name (default: Iris)")
@click.option("--name", default="Keyrus", help="Name of the company")
@click.option(
    "--metadata",
    default="France, Lyon, DS Team",
    callback=parse_labels,
    help="Meta data from the collected team",
)
def hello_world(dataset, name, metadata):
    # Print hello world Iris
    logger.info("Welcome to Hello World to: " + name)
    logger.info("Selected Dataset " + dataset)
    logger.info(f"List of the metadata {metadata}")


cli.add_command(hello_world)

if __name__ == "__main__":
    cli()

# %%
