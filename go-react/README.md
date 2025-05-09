# Todo List Application

A modern, full-stack Todo List application built with Go (backend) and React + TypeScript (frontend). This application allows users to manage their tasks efficiently with a clean and intuitive interface.

## Technologies Used

### Backend

- Go
- Go standard library (`net/http`) for HTTP server
- Air (Live reload for Go apps)

### Frontend

- React 18
- TypeScript
- Vite (Build tool)
- ESLint (Code quality)

## Setup and Installation

### Prerequisites

- Go 1.21 or higher
- Node.js 18 or higher
- npm or yarn

### Backend Setup

1. Clone the repository

```bash
git clone <your-repo-url>
cd go-react
```

2. Install Go dependencies

```bash
go mod tidy
```

3. Run the backend server (with hot reload)

```bash
air
```

The server will start at `http://localhost:8080`

### Frontend Setup

1. Navigate to the client directory

```bash
cd client
```

2. Install dependencies

```bash
npm install
# or
yarn install
```

3. Start the development server

```bash
npm run dev
# or
yarn dev
```

The frontend will be available at `http://localhost:5173`

## Features

- Create, Read, Update, and Delete todos
- Mark todos as complete/incomplete
- Modern and responsive user interface
- Real-time updates
- Type-safe codebase

## Project Structure

```
go-react/
├── main.go           # Backend entry point
├── client/          # Frontend React application
│   ├── src/         # Source code
│   ├── public/      # Static assets
│   └── ...
└── ...
```

## Known Issues & Future Improvements

- [ ] Add user authentication
- [ ] Implement todo categories/tags
- [ ] Add due dates for todos
- [ ] Implement data persistence
- [ ] Add unit tests
- [ ] Add dark mode support

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

_Note: This is a development project and may contain bugs or incomplete features. Please report any issues you find._
