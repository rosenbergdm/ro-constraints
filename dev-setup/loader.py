#!/usr/bin/env python3

import sqlite3
import psycopg2
import re
import sys
import csv
import os


targets = []
fractionations = []
volume_types = []
dose_types = []
disease_sites = []
regions = []
region_disease_sites = []
protocols = []
region_protocols = []
publications = []
region_publications = []
notes = []
intents = []


def add_target(name, alphabeta=None):
    global targets
    if len(targets) == 0 or name not in [x[1] for x in targets]:
        targets.append((len(targets) + 1, name, alphabeta))
        return targets[-1][0]
    else:
        return targets[[n for n, x in enumerate(targets) if x[1] == name][0]][0]


def add_fractionation(description=None, fractions_min=None, fractions_max=None):
    global fractionations
    if len(fractionations) == 0 or (
        (description is not None and description not in [x[1] for x in fractionations])
        or (fractions_min, fractions_max) not in [(x[2], x[3]) for x in fractionations]
    ):
        fractionations.append(
            (len(fractionations) + 1, description, fractions_min, fractions_max)
        )
        return fractionations[-1][0]
    else:
        if description is not None and description in [x[1] for x in fractionations]:
            return fractionations[
                [n for n, x in enumerate(fractionations) if x[1] == description][0]
            ][0]
        else:
            return fractionations[
                [
                    n
                    for n, x in enumerate(fractionations)
                    if x[2] == fractions_min and x[3] == fractions_max
                ][0]
            ][0]


def add_volume_type(description=None):
    global volume_types
    if len(volume_types) == 0 or description not in [x[1] for x in volume_types]:
        volume_types.append((len(volume_types) + 1, description))
        return volume_types[-1][0]
    else:
        return volume_types[
            [n for n, x in enumerate(volume_types) if x[1] == description][0]
        ][0]


def add_dose_type(description=None):
    global dose_types
    if len(dose_types) == 0 or description not in [x[1] for x in dose_types]:
        dose_types.append((len(dose_types) + 1, description))
        return dose_types[-1][0]
    else:
        return dose_types[
            [n for n, x in enumerate(dose_types) if x[1] == description][0]
        ][0]


def add_disease_site(description=None):
    global disease_sites
    if len(disease_sites) == 0 or description not in [x[1] for x in disease_sites]:
        disease_sites.append((len(disease_sites) + 1, description))
        return disease_sites[-1][0]
    else:
        return disease_sites[
            [n for n, x in enumerate(disease_sites) if x[1] == description][0]
        ][0]


def add_region_disease_site(region, disease_site):
    global region_disease_sites
    region_disease_sites.append((len(region_disease_sites) + 1, region, disease_site))
    region_disease_sites[-1][0]


def add_protocol(name, year=None):
    global protocols
    if len(protocols) == 0 or name not in [x[1] for x in protocols]:
        protocols.append((len(protocols) + 1, name, year))
    else:
        return protocols[[n for n, x in enumerate(protocols) if x[1] == name][0]][0]


def add_publication(title, doi=None, pubmed=None):
    global publications
    if len(publications) == 0 or title not in [x[1] for x in publications]:
        publications.append((len(publications) + 1, title, doi, pubmed))
    else:
        return publications[
            [n for n, x in enumerate(publications) if x[1] == title][0]
        ][0]


def add_note(region, text):
    global notes
    global regions
    region_id = regions[[n for n, x in enumerate(regions) if x[1] == region][0]][0]
    notes.append((len(notes) + 1, region_id, text))
    return notes[-1][0]


def add_intent(description):
    global intents
    if len(intents) == 0 or description not in [x[1] for x in intents]:
        intents.append((len(intents) + 1, description))
        return intents[-1][0]
    else:
        return intents[[n for n, x in enumerate(intents) if x[1] == description][0]][0]


def add_region_protocol(region, protocol):
    global regions
    global protocols
    global region_protocols
    region_id = regions[[n for n, x in enumerate(regions) if x[1] == region][0]][0]
    protocol_id = protocols[
        [n for n, x in enumerate(protocols) if x[1] == protocol][0]
    ][0]
    region_protocols.append((len(protocol) + 1, region_id, protocol_id))
    region_protocols[-1][0]


def add_region_publication(region, publication):
    global regions
    global publications
    global region_publications
    region_id = regions[[n for n, x in enumerate(regions) if x[1] == region][0]][0]
    publication_id = publications[
        [n for n, x in enumerate(publications) if x[1] == publication][0]
    ][0]
    region_publications.append((len(publication) + 1, region_id, publication_id))
    region_publications[-1][0]


def add_region(
    target,
    primary,
    fractionation,
    intent=None,
    volume=None,
    volume_type=None,
    volume_deviation=None,
    volume_deviation_type=None,
    prv=None,
    dose=None,
    dose_type=None,
    dose_deviation=None,
    dose_deviation_type=None,
    conversion=None,
    extrapolation=None,
):
    global volume_types
    global volume_deviations
    global dose_types
    global dose_deviations
    global regions
    global targets
    regions.append(
        (
            len(regions) + 1,
            target,
            primary,
            fractionation,
            intent,
            volume,
            volume_type,
            volume_deviation,
            volume_deviation_type,
            prv,
            dose,
            dose_type,
            dose_deviation,
            dose_deviation_type,
            conversion,
            extrapolation,
        )
    )
    return regions[-1][0]



def process_line(l):
    global targets, fractionations, volume_types, dose_types
    global disease_sites, regions, region_disease_sites, protocols
    global region_protocols, publications, region_publications, notes, intents
    # region_id = len(regions) + 1
    result = []
    result.append(add_target(l[1])) # target
    result.append(add_target(l[4])) # oncprimary
    mt = re.match(r"(\d+)-?(\d*)", l[2])
    if mt:
        dmin = int(mt.groups()[0])
        dmax = None if mt.groups()[1] == "" else int(mt.groups()[1])
        result.append(add_fractionation(fractions_min=dmin, fractions_max=dmax))
    else:
        result.append(add_fractionation(l[2])) # fractionation
    if l[3] != "":
        result.append(add_intent(l[3])) # intent
    else:
        result.append(None)
    if l[5] == "":
        result.append(None)
        result.append(None)
    elif l[5] == "n/a":
        result.append(None)
        result.append(None)
    else:
        mt = re.match(r"^(\d+\.?\d*) ?(.*)$", l[5])
        if mt:
            (v, vtype) = mt.groups()
            result.append(int(100 * float(v)))
            result.append(add_volume_type(vtype))
        else:
            result.append(0)
            result.append(add_volume_type("MAX"))
    if l[6] == "":
        result.append(None)
        result.append(None)
    elif l[6] == "n/a":
        result.append(None)
        result.append(None)
    else:
        mt = re.match(r"^(\d+) ?(.*)$", l[6])
        if mt:
            (v, vtype) = mt.groups()
            result.append(int(100 * float(v)))
            result.append(add_volume_type(vtype))
        else:
            result.append(0)
            result.append(add_volume_type("MAX"))
    result.append(
        None
        if l[7] == ""
        else int(100 * float(re.sub(r"^(\d+\.?\d*) .*$", "\\1", l[7])))
    )
    if l[8] == "":
        result.append(None)
        result.append(None)
    elif l[8] == "n/a":
        result.append(None)
        result.append(None)
    elif l[8] == "ALARA":
        result.append(None)
        result.append(None)
    else:
        mt = re.match(r"^(\d+\.?\d*) *(.*)$", l[8])
        (d, dtype) = mt.groups()
        result.append(int(100 * float(d)))
        result.append(add_dose_type(dtype.capitalize()))
    if l[9] == "":
        result.append(None)
        result.append(None)
    elif l[9] == "n/a":
        result.append(None)
        result.append(None)
    else:
        mt = re.match(r"^(\d+\.?\d*) ?(.*)$", l[9])
        (d, dtype) = mt.groups()
        result.append(int(100 * float(d)))
        result.append(add_dose_type(dtype))
    result.append(None if l[10] == "" else l[10])
    result.append(None if l[14] == "" else l[14])
    add_region(*result)
    return regions[-1][0]


def load_targets_pg(conn):
    global targets
    cur = conn.cursor()
    for t in targets:
        cur.execute(
            "INSERT INTO target (name, alphabeta) VALUES (%s, %s)", (t[1], t[2])
        )
    conn.commit()


def load_fractionations_pg(conn):
    global fractionations
    cur = conn.cursor()
    for t in fractionations:
        cur.execute("INSERT INTO fractionation VALUES (%s, %s, %s, %s)", t)
    conn.commit()


def load_dose_types_pg(conn):
    global dose_types
    cur = conn.cursor()
    for t in dose_types:
        cur.execute("INSERT INTO dose_type VALUES (%s, %s)", t)
    conn.commit()


def load_volume_types_pg(conn):
    global volume_types
    cur = conn.cursor()
    for t in volume_types:
        cur.execute("INSERT INTO volume_type VALUES (%s, %s)", t)
    conn.commit()


def load_intents_pg(conn):
    global intents
    cur = conn.cursor()
    for t in intents:
        cur.execute("INSERT INTO intent VALUES (%s, %s)", t)
    conn.commit()


def load_disease_sites_pg(conn):
    global disease_sites
    cur = conn.cursor()
    for t in disease_sites:
        cur.execute("INSERT INTO disease_site VALUES (%s, %s)", t)
    conn.commit()


def load_regions_pg(conn):
    global regions
    cur = conn.cursor()
    for t in regions:
        cur.execute(
            "INSERT INTO region VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
            t,
        )
    conn.commit()


def load_region_disease_sites_pg(conn):
    global region_disease_sites
    cur = conn.cursor()
    for t in region_disease_sites:
        cur.execute("INSERT INTO region_disease_site VALUES (%s, %s, %s)", t)
    conn.commit()


def main_pg(dbname="constraints"):
    db = psycopg2.connect(dbname=dbname, user='dmr', password='dmr5669')
    db.autocommit = True
    srcfile = "Treatment Planning-Grid view (3).csv"
    cur = db.cursor()
    schemafile = "ro-constraints.pssql"
    with open(schemafile) as fh:
        cur.execute(fh.read())
        db.commit()
    with open(srcfile, "r") as fh:
        reader = csv.reader(fh)
        reader.__next__()
        for r in reader:
            process_line(r)
        db.commit()
    load_targets_pg(db)
    load_fractionations_pg(db)
    load_dose_types_pg(db)
    load_volume_types_pg(db)
    load_disease_sites_pg(db)
    load_intents_pg(db)
    load_regions_pg(db)
    load_region_disease_sites_pg(db)
    db.commit()
    db.close()


def load_targets_lite(conn):
    global targets
    cur = conn.cursor()
    for t in targets:
        cur.execute("INSERT INTO target (name, alphabeta) VALUES (?, ?)", (t[1], t[2]))
    conn.commit()


def load_fractionations_lite(conn):
    global fractionations
    cur = conn.cursor()
    for t in fractionations:
        cur.execute("INSERT INTO fractionation VALUES (?, ?, ?, ?)", t)
    conn.commit()


def load_dose_types_lite(conn):
    global dose_types
    cur = conn.cursor()
    for t in dose_types:
        cur.execute("INSERT INTO dose_type VALUES (?, ?)", t)
    conn.commit()


def load_volume_types_lite(conn):
    global volume_types
    cur = conn.cursor()
    for t in volume_types:
        cur.execute("INSERT INTO volume_type VALUES (?, ?)", t)
    conn.commit()


def load_intents_lite(conn):
    global intents
    cur = conn.cursor()
    for t in intents:
        cur.execute("INSERT INTO intent VALUES (?, ?)", t)
    conn.commit()


def load_disease_sites_lite(conn):
    global disease_sites
    cur = conn.cursor()
    for t in disease_sites:
        cur.execute("INSERT INTO disease_site VALUES (?, ?)", t)
    conn.commit()


def load_region_disease_sites_lite(conn):
    global region_disease_sites
    cur = conn.cursor()
    for t in region_disease_sites:
        cur.execute("INSERT INTO region_disease_site VALUES (?, ?, ?)", t)
    conn.commit()


def load_regions_lite(conn):
    global regions
    cur = conn.cursor()
    for t in regions:
        cur.execute(
            "INSERT INTO region VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", t
        )
    conn.commit()


def main_sqlite(dbfile="ro-constraints.sql"):
    db = sqlite3.connect(":memory:")
    srcfile = "Treatment Planning-Grid view (3).csv"
    cur = db.cursor()
    schemafile = "ro-constraints.sql"
    with open(schemafile) as fh:
        cur.executescript(fh.read())
        db.commit()
    with open(srcfile, "r") as fh:
        reader = csv.reader(fh)
        reader.__next__()
        for r in reader:
            process_line(r)
    load_targets_lite(db)
    load_fractionations_lite(db)
    load_dose_types_lite(db)
    load_volume_types_lite(db)
    load_intents_lite(db)
    load_disease_sites_lite(db)
    load_region_disease_sites_lite(db)
    load_regions_lite(db)
    tgtfile = dbfile
    with sqlite3.connect(tgtfile) as bkdb:
        db.backup(bkdb)
    bkdb.close()
    db.close()
    db.close()
