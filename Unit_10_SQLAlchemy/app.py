# STARTER CODE PROVIDED BY ALEXANDER 

from flask import Flask, jsonify

import numpy as np
import pandas as pd
import datetime as dt

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, inspect, func

engine = create_engine("sqlite:///C:/Users/julia/Documents/SMU Data Science Bootcamp/SMU-DAL-DATA-PT-08-2019-U-C/02-Homework/10-Advanced-Data-Storage-and-Retrieval/Instructions/Resources/hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save reference to the table
# Passenger = Base.classes.

#################################################
# Flask Setup
#################################################
app = Flask(__name__)


#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    return (
        f"Welcome to the Weater API!<br/>"
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation/"
        f"/api/v1.0/precipitation/<start_date>/<end_date>/"
        f"/api/v1.0/station/"
        f"/api/v1.0/tobs/"
        f"/api/v1.0/<start>/"
        f"/api/v1.0/<start>/<end>/"
    )

@app.route("/api/v1.0/precipitation/")
def get_precipitation():
    conn = engine.connect()

    precipQuery = f"""
                SELECT
                    date,
                    prcp
                FROM
                    measurement
                """

    df = pd.read_sql(precipQuery, conn)
    return jsonify(df.to_json())

@app.route("/api/v1.0/precipitation/<start_date>/<end_date>/")
def get_precipitation_forDates(start_date, end_date):
    conn = engine.connect()

    precipQuery = f"""
                SELECT
                    date,
                    prcp
                FROM
                    measurement
                WHERE
                    date > '{start_date}'
                    AND date <= '{end_date}'
                """

    df = pd.read_sql(precipQuery, conn)
    return jsonify(df.to_json())


@app.route("/api/v1.0/station/")
def get_stations():
    conn = engine.connect()

    stationQuery = f"""
                SELECT DISTINCT
                    station
                FROM
                    station
                """

    df = pd.read_sql(stationQuery, conn)
    return jsonify(df.to_json())

if __name__ == "__main__":
    app.run(debug=True)

# @app.route("/api/v1.0/station/")
# def calc_temps(start_date, end_date):

#     return session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
#         filter(Measurement.date >= start_date).filter(Measurement.date <= end_date).all()

# # function usage example
# bar_temps = calc_temps('2011-02-28', '2011-03-05')[0]
# bar_temps