from io import BytesIO

import pandas as pd
import pretty_errors  # noqa: F401
import streamlit as st
from loguru import logger
from pygwalker.api.streamlit import StreamlitRenderer


def set_page_config():
    logger.info("Configure page layout")
    st.set_page_config(
        page_title="Keyrus Template Streamlit App", page_icon=":camera:", layout="wide"
    )


def set_app_config():
    st.title("Keyrus Template Streamlit App")
    st.text("Author: Keyrus - Lyon Data Science Team")
    st.markdown("*Example of an Streamlit template application*")


def add_company_logo():
    logger.info("Add company logo to the sidebar")
    st.sidebar.image("https://www.semarchy.com/wp-content/uploads/2022/04/original.png")


def display_information():
    logger.info("Display information")
    df_data = pd.DataFrame([1, 2, 3])
    return df_data


def generate_data(df_data, DICT_PARAM):
    logger.info("Generate data")
    df_generated_data = df_data * 2
    return df_generated_data


def display_generated_data(df_data, df_generated_data):
    logger.info("Display generated data")
    st.markdown("---")
    st.subheader("📅 Example of Synthetic Data")
    # Use columns to display statistics side by side
    col1, col2 = st.columns(2)

    with col1:
        st.subheader("Fake Data")
        st.dataframe(df_data.head(5))

    with col2:
        st.subheader("Generated Data")
        st.dataframe(df_generated_data.head(5))


def sidebar():
    logger.info("Sidebar with user selections")
    with st.sidebar:
        st.markdown("---")
        st.subheader("📁 Upload Required Files")
        # Upload a file
        dataset = st.file_uploader("📊 Dataset (Parquet)", type=["parquet"])

        # Choose dataset
        dataset_options = ["Iris", "Titanic", "Adult"]
        st.session_state["selected_dataset"] = st.selectbox(
            "Select Dataset", dataset_options
        )

        # Input for nb_data
        st.session_state["nb_data"] = st.number_input(
            "Enter the number of synthetic data to generate", value=100
        )

    return dataset


def handle_pygwalker(dataset):
    if dataset is not None:
        st.markdown("---")
        st.subheader("📊 Explore Data interactively")

        if "pyg_data" not in st.session_state:
            try:
                dataset_bytes = dataset.read()
                st.session_state.pyg_data = pd.read_parquet(BytesIO(dataset_bytes))
            except Exception as e:
                st.error(f"Error reading dataset file: {e}")
                return

        if "pyg_app" not in st.session_state:
            st.session_state.pyg_app = StreamlitRenderer(st.session_state.pyg_data)

        st.session_state.pyg_app.explorer()


def main():
    # Global configuration
    set_page_config()
    set_app_config()
    add_company_logo()

    # Initialize variables
    DICT_PARAM = {}

    dataset = sidebar()

    DICT_PARAM["selected_dataset"] = st.session_state["selected_dataset"]
    DICT_PARAM["nb_data"] = st.session_state["nb_data"]

    logger.info(DICT_PARAM)

    df_data = display_information()

    if st.button("Generate and Visualize"):
        df_generated_data = generate_data(df_data, DICT_PARAM)
        display_generated_data(df_data, df_generated_data)

    handle_pygwalker(dataset)


if __name__ == "__main__":
    logger.info("====================================")
    logger.info("START the Streamlit App Execution")

    main()

    logger.info("END the Streamlit App Execution")
    logger.info("====================================")
