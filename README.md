# My E-commerce App

## Overview
This is a **Flutter-based E-commerce mobile application** that allows users to register, sign in, browse products, add items to a shopping cart, mark favorites, and complete purchases. The app is integrated with **Firebase Authentication** and **Cloud Firestore**, and supports **Google** and **Facebook login**.  

The application is fully mobile-optimized and demonstrates best practices in Flutter development, state management using **Provider**, and UI/UX design.

---

## Features

### Welcome Screen
- AppBar with application title and logo.
- Two images: one from assets and one from a URL.
- Custom font (Roboto).
- Sign Up and Sign In buttons.
- Circular logo display for better UI.

### Sign Up Form
- Fields: **Full Name, Email, Password, Confirm Password**.
- Validation:
  - Full Name: First letter uppercase.
  - Email must contain "@".
  - Password: Minimum 6 characters.
  - Confirm Password must match Password.
- **Google** and **Facebook Sign In**.
- After successful submission: Dialog appears → redirects to **Home Page**.
- State management handled via **Provider**.

### Sign In Form
- Fields: **Email and Password**.
- Validation:
  - Email must contain "@".
  - Password: Minimum 6 characters.
- Dialog on successful login → redirects to **Home Page**.
- Google and Facebook login integrated.
- Provider handles user authentication state.

### Home Page
- Displays a **list of products**.
- Features:
  - Add to cart
  - Mark as favorite
  - Buy now
- State management for **cart** and **favorites** using Provider.

### Firebase Integration
- **Authentication** for email/password, Google, and Facebook.
- **Firestore** to store user data (uid, name, email, photo, provider).

---

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone <your_repo_url>
