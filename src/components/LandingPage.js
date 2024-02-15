import { useState } from 'react';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import axios from 'axios';
import "./landingPage.css"

function LandingPage() {
    const [questionInput, setQuestionInput] = useState("")
    const [answerInput, setAnswerInput] = useState("What's your question?")

    const projectID = process.env.REACT_APP_PROJECT_ID
    const location = process.env.REACT_APP_LOCATION
    const function_name = process.env.REACT_APP_FUNCTION_NAME


    const handleQuestionChange = (e) => {
        const { value } = e.target;
        setQuestionInput(value)
    }

    const submitQuestion = () => {
        console.log(questionInput)

        const function_url = `https://${location}-${projectID}.cloudfunctions.net/${function_name}`

        axios({
            method: 'post',
            url: function_url,
            data: {
                question: questionInput
            },
        })
            .then((response) => {
                console.log(response.data);
                setAnswerInput(response.data)
            })
            .catch((error) => {
                console.log("DIDN'T WORK")
                console.log(error);
            });
    }

    return (
        <Container fluid>
            <Row className='robot-spacing'>
                <Col></Col>
                <Col>
                    <Row>
                        <Col>
                            <div className="speech-bubble">
                                <h1>{answerInput}</h1>
                            </div>
                        </Col>
                    </Row>
                    <Row>
                        <Col>
                            <img src={require("../assets/math_robot_friend.png")} alt="Little Robot" width="150" height="150" />
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