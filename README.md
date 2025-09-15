# Health Wallet

is an open-source, self-hosted, personal/family electronic medical record aggregator. It's a mobile application designed to securely connect and sync your health data with a local FastenHealth On-Prem instance.

The goal is to create a private, unified health record that you control, integrating with thousands of insurances, hospitals, and clinics through the FastenHealth platform.

Tags
emr open-source healthcare electronic-health-record personal-health-record electronic-medical-record

# How it Works
This app acts as the mobile front-end for your self-hosted FastenHealth On-Prem server. It connects securely to your local Fasten instance to display, manage, and interact with your aggregated medical records.

# Key Features

Self-Hosted & Private: Your data stays on your local network. This app does not connect to any cloud services or third-party servers.

Aggregates Your Data: Connects to your FastenHealth server, which pulls records from multiple healthcare providers into one place.

FHIR Support: Leverages the industry-standard FHIR protocol used by FastenHealth for secure data exchange.

Peer to peer sharing

On-Device AI assitant (comming soon)

Scan to FHIR on device. Scan any medical document and get it insert in the database by keeping the initial document as an attachement.

Built with Flutter: A single codebase for both iOS and Android.

# Development
This is a standard Flutter project. To get started:

Clone the repository:

```bash
git clone [your-repo-link]
cd health_wallet
```

# Get dependencies:

Bash
```bash
flutter pub get
Run the app:
```


```bash
flutter run

```

Connect to Fasten:
The app will prompt you to enter the address of your local FastenHealth On-Prem instance to establish a connection.