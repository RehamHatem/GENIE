from flask import Flask, request, jsonify
from sentence_transformers import SentenceTransformer
import torch

app = Flask(__name__)
model = SentenceTransformer("sentence-transformers/all-MiniLM-L6-v2")

@app.route('/embedding', methods=['POST'])
def embedding():
    data = request.json
    text = data.get("text")
    embedding = model.encode(text).tolist()
    return jsonify(embedding)

@app.route('/search', methods=['POST'])
def search():
    data = request.json
    query_embedding = torch.tensor(data.get("query_embedding"))
    captions_embeddings = torch.tensor(data.get("captions_embeddings"))

    similarities = torch.nn.functional.cosine_similarity(
        query_embedding.unsqueeze(0),
        captions_embeddings
    )
    similarities = similarities.tolist()

    # Get indices of the top 5 most similar embeddings
    sorted_indices = sorted(range(len(similarities)), key=lambda i: similarities[i], reverse=True)[:5]

    return jsonify(sorted_indices)
if __name__ == '__main__':
    app.run(debug=True)
