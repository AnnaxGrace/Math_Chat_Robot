import { useState } from 'react';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import "./landingPage.css"

function LandingPage() {
    const [questionInput, setQuestionInput] = useState("")
    const [answerInput, setAnswerInput] = useState("What's your question?")

    const handleQuestionChange = (e) => {
        const { value } = e.target;
        setQuestionInput(value)
    }

    const submitQuestion = () => {
        console.log(questionInput)
    }

    return (
        <Container fluid>
            <Row className='robot-spacing'>
                <Col></Col>
                <Col>
                    <Row>
                        <Col>
                        <img src={require("../assets/math_robot_friend.png")} alt="Little Robot" width="150" height="150"/>
                        <div className="speech-bubble">
                            <h1>{answerInput}</h1>
                        </div>
                        </Col>
                    </Row>
                </Col>
                <Col></Col>
            </Row>
            <Row>
                <Col></Col>
                <Col>
                    <Form>
                        <Form.Group className="mb-3" controlId="robot-question">
                            {/* <Form.Label>Let me answer your question!</Form.Label> */}
                            <Form.Control type="" onChange={(e) => handleQuestionChange(e)} value={questionInput} placeholder="Enter your question!" />
                        </Form.Group>

                        <Button variant="primary" onClick={submitQuestion}>
                            Submit
                        </Button>
                    </Form></Col>
                <Col></Col>
            </Row>
        </Container>
    )
}

export default LandingPage;