import streamlit as st
import pandas as pd


st.write("""
#My first App
Hello
""")


df = pd.read_csv("iherb_products루테인.csv")
st.line_chart(df)