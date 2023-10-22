import { Container } from "react-bootstrap";

import ButtonTemplate from "./components/templates/ButtonTemplate";
import TypographyTemplate from "./components/templates/TypographyTemplate";

function App() {
  return (
    <>
      <Container>
        <ButtonTemplate />
        <div className="my-3" />
        <TypographyTemplate />
      </Container>
    </>
  );
}

export default App;
