import { BrowserRouter, Routes, Route } from "react-router-dom";
import 'bootstrap/dist/css/bootstrap.min.css';
import LandingPage from "./components/LandingPage";
import './App.css';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="*" element={<LandingPage />}>
          <Route index element={<LandingPage/>} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
