from fastapi import FastAPI
from pydantic import BaseModel
from transformers import pipeline, AutoTokenizer, AutoModelForSeq2SeqLM

app = FastAPI()

# Load pre-trained model
tokenizer = AutoTokenizer.from_pretrained("microsoft/DialoGPT-medium")
model = AutoModelForSeq2SeqLM.from_pretrained("microsoft/DialoGPT-medium")
chatbot = pipeline("text-generation", model=model, tokenizer=tokenizer)

class ChatRequest(BaseModel):
    message: str
    chat_history: list[str] = []

@app.post("/chat")
async def chat_endpoint(request: ChatRequest):
    # Format input with chat history
    input_text = "\n".join(request.chat_history[-5:] + [request.message])
    
    # Generate response
    response = chatbot(
        input_text,
        max_length=1000,
        pad_token_id=tokenizer.eos_token_id,
        no_repeat_ngram_size=3,
        do_sample=True,
        top_k=100,
        top_p=0.7,
        temperature=0.8
    )
    
    return {
        "response": response[0]['generated_text'].split("\n")[-1],
        "chat_history": request.chat_history + [request.message, response[0]['generated_text']]
    }

@app.get("/health")
async def health_check():
    return {"status": "healthy"}