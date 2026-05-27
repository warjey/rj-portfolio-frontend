# 🚀 RJ Portfolio — Complete Setup Guide
## From Zero to Deployed in VSCode

---

## PART 1 — INSTALL REQUIRED TOOLS

Before anything, install these (if you don't have them yet):

| Tool | Download Link | Why |
|------|--------------|-----|
| Flutter SDK | https://flutter.dev/docs/get-started/install | Run the Flutter app |
| Node.js (LTS) | https://nodejs.org | Run the backend |
| VS Code | https://code.visualstudio.com | Code editor |
| Git | https://git-scm.com | Version control for deployment |

### VS Code Extensions to install:
Open VS Code → Extensions (Ctrl+Shift+X) → search and install:
- **Flutter** (by Dart Code)
- **Dart** (by Dart Code)
- **REST Client** (optional, for testing API)

---

## PART 2 — FLUTTER FRONTEND SETUP

### Step 1: Create the Flutter project
Open VS Code terminal (Ctrl+`) and run:

```bash
flutter create rj_portfolio
cd rj_portfolio
```

### Step 2: Replace the files
Delete everything inside the `lib/` folder, then copy these files into their correct folders:

```
rj_portfolio/
├── lib/
│   ├── main.dart                          ← copy main.dart here
│   ├── models/
│   │   └── portfolio_data.dart            ← copy here
│   ├── screens/
│   │   └── home_screen.dart               ← copy here
│   └── widgets/
│       ├── navbar.dart                    ← copy here
│       ├── hero_section.dart              ← copy here
│       ├── about_section.dart             ← copy here
│       ├── projects_section.dart          ← copy here
│       ├── skills_section.dart            ← copy here
│       └── contact_section.dart           ← copy here
├── pubspec.yaml                           ← replace with provided file
└── web/
    └── index.html                         ← keep default Flutter web file
```

### Step 3: Create the assets folder
```bash
mkdir -p assets/images
```
(You can add your photo later as `assets/images/profile.jpg`)

### Step 4: Install dependencies
```bash
flutter pub get
```

### Step 5: Run the app in browser
```bash
flutter run -d chrome
```

---

## PART 3 — BACKEND SETUP

### Step 1: Create a new folder OUTSIDE the Flutter project
```bash
mkdir rj_portfolio_backend
cd rj_portfolio_backend
```

### Step 2: Copy these files into rj_portfolio_backend/
```
rj_portfolio_backend/
├── server.js
├── package.json
├── .env.example
└── .gitignore
```

### Step 3: Install Node packages
```bash
npm install
```

### Step 4: Setup your .env file
```bash
# Copy the example file
cp .env.example .env
```
Then open `.env` and fill in:
- `EMAIL_USER` = your Gmail address
- `EMAIL_PASS` = your Gmail App Password

**How to get Gmail App Password:**
1. Go to myaccount.google.com
2. Security → 2-Step Verification (enable it first)
3. App Passwords → Generate one for "Mail"
4. Copy the 16-character password into .env

### Step 5: Start the backend
```bash
npm run dev
```
You should see: `🚀 RJ Portfolio Backend running on http://localhost:3000`

### Step 6: Test it
Open browser and go to: http://localhost:3000
You should see: `{"status":"ok","message":"RJ Portfolio Backend is running 🚀"}`

---

## PART 4 — CONNECT FRONTEND TO BACKEND

In `lib/widgets/contact_section.dart`, find this line:
```dart
// Simulate sending — replace with your backend call
await Future.delayed(const Duration(seconds: 2));
```

Replace the `_submit` function with this real API call:

```dart
Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;
  setState(() => _sending = true);
  try {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/contact'), // Change to your backend URL after deploy
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': _nameController.text,
        'email': _emailController.text,
        'message': _messageController.text,
      }),
    );
    final data = jsonDecode(response.body);
    if (data['success']) {
      setState(() { _sending = false; _sent = true; });
    }
  } catch (e) {
    setState(() => _sending = false);
  }
}
```

Also add `http` package to pubspec.yaml dependencies:
```yaml
http: ^1.1.0
```
Then run: `flutter pub get`

And add these imports to contact_section.dart:
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
```

---

## PART 5 — DEPLOY FRONTEND TO VERCEL

### Step 1: Build Flutter for web
```bash
cd rj_portfolio
flutter build web --release
```
This creates a `build/web/` folder.

### Step 2: Install Vercel CLI
```bash
npm install -g vercel
```

### Step 3: Deploy
```bash
cd build/web
vercel
```
Follow the prompts:
- Set up project? → Y
- Project name → rj-portfolio
- Directory → ./  (current)
- Override settings? → N

Vercel will give you a URL like: `https://rj-portfolio.vercel.app` 🎉

---

## PART 6 — DEPLOY BACKEND TO RENDER (Free)

Vercel is for frontend. Use **Render.com** for the Node.js backend (also free).

### Step 1: Push backend to GitHub
```bash
cd rj_portfolio_backend
git init
git add .
git commit -m "Initial backend"
# Create a repo on github.com first, then:
git remote add origin https://github.com/YOUR_USERNAME/rj-portfolio-backend.git
git push -u origin main
```

### Step 2: Deploy on Render
1. Go to https://render.com and sign up (free)
2. New → Web Service
3. Connect your GitHub repo
4. Settings:
   - Build Command: `npm install`
   - Start Command: `node server.js`
5. Add Environment Variables:
   - `EMAIL_USER` = your Gmail
   - `EMAIL_PASS` = your App Password
6. Click Deploy!

Render gives you a URL like: `https://rj-portfolio-backend.onrender.com`

### Step 3: Update frontend URL
In `contact_section.dart`, change `localhost:3000` to your Render URL:
```dart
Uri.parse('https://rj-portfolio-backend.onrender.com/api/contact'),
```
Then rebuild and redeploy to Vercel.

---

## ✅ DONE! Your portfolio is live!

**Frontend:** https://rj-portfolio.vercel.app
**Backend:** https://rj-portfolio-backend.onrender.com

---

## 🔧 Troubleshooting

| Problem | Fix |
|---------|-----|
| `flutter: command not found` | Add Flutter to PATH, restart VS Code |
| `npm: command not found` | Reinstall Node.js |
| Email not sending | Check App Password, enable 2FA on Gmail |
| CORS error | Update CORS origin in server.js to your Vercel URL |
| Vercel deploy fails | Make sure you're inside `build/web/` folder |
