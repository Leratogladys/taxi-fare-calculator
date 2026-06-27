# TaxiMaths 🚕

A Flutter-based taxi management application designed to simplify fare calculation, passenger payments, and trip tracking for South Africa's informal taxi industry.

## Overview

TaxiMaths is a mobile application built to help taxi drivers, conductors, and operators manage daily taxi operations more efficiently.

The app addresses common challenges in the taxi industry such as manual fare calculations, payment tracking, change management, and revenue visibility.

The goal is to create an offline-first digital tool that improves accuracy, reduces payment disputes, and simplifies taxi operations.

---

# Problem

South African taxi operations often rely on manual calculations and memory-based tracking.

This creates challenges such as:

- Incorrect fare calculations
- Difficulty tracking passenger payments
- Managing change owed to passengers
- Tracking daily revenue
- Delays during busy periods

TaxiMaths aims to digitize these processes into a simple and practical mobile solution.

---

# Features

## Current Features 🚧

### Fare Calculation

Calculate total fares based on:

- Number of passengers
- Fare per passenger

Example:
10 passengers × R15 = R150

---

### Payment Tracking

Record passenger payments and calculate:

- Amount received
- Remaining balance
- Change owed

---

### Change Management

Track outstanding change and payment completion status.

---

### Trip Management

Manage trip information including:

- Passenger groups
- Fare stages
- Trip status

---

# Planned Features

## Route Library

Save frequently used taxi routes.

Examples:
Soweto → Johannesburg CBD
Tembisa → Midrand
Alexandra → Sandton

---

## Reverse Fare Calculation

Calculate passenger count from collected money.

Example:


Collected: R450
Fare: R15

Passengers:
450 ÷ 15 = 30 passengers

---

## Multi-stage Trips

Support journeys with multiple route sections.

Example:


Alex → Sandton
Sandton → Randburg


---

## Offline-first Storage

Local data storage using Hive.

Future synchronization using Supabase.

---

# Technology Stack

## Frontend

- Flutter
- Dart

## Architecture

- MVVM (Model-View-ViewModel)

## State Management

- Provider

## Local Storage

- Hive (planned)

## Backend

- Supabase (planned)

---

# Architecture

TaxiMaths follows an MVVM architecture:


View
|
|
ViewModel
|
|
Model


This separates:

- UI components
- Business logic
- Data models

Making the application easier to maintain and scale.

---

# Project Structure


lib/

├── core/
│ ├── constants/
│ └── theme/

├── models/

├── viewmodels/

├── views/

├── widgets/

└── routes/


---

# Design Philosophy

The design direction is inspired by modern transport and fintech applications.

Goals:

- Simple user experience
- Fast interactions
- Large touch-friendly components
- Minimal distractions
- Practical for taxi rank environments

---

# Screenshots

Coming soon 🚧

---

# Development Roadmap

## Phase 1 — Foundation ✅

- MVVM architecture
- Navigation
- Theme system
- Models
- ViewModels

## Phase 2 — Core Taxi Operations 🚧

- Fare calculations
- Payment tracking
- Change management

## Phase 3 — Persistence

- Hive local storage
- Trip history
- Saved routes

## Phase 4 — Advanced Features

- Route library
- Analytics
- Revenue tracking

## Phase 5 — Cloud Features

- Supabase authentication
- Data synchronization
- Fleet management

---

# Why This Project?

TaxiMaths is built as a portfolio project exploring how software can solve real-world problems in local communities.

The project demonstrates:

- Flutter application development
- MVVM architecture
- State management
- Product thinking
- Solving problems within a specific market

---

# Author

Lerato Gladys

GitHub:
https://github.com/Leratogladys

Portfolio:
https://leratogladys.github.io/Portfolio

---

# License

This project is currently under active development.
