require('dotenv').config();
const express = require('express');
const fetch   = require('node-fetch');
const path    = require('path');

const app  = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(express.static(path.join(__dirname)));  // serve HTML/CSS/JS files

// ── AI proxy endpoint ─────────────────────────────────────────────────────────
app.post('/api/chat', async (req, res) => {
  const apiKey = process.env.ANTHROPIC_API_KEY;
  if (!apiKey) {
    return res.status(500).json({ error: 'ANTHROPIC_API_KEY is not configured on the server.' });
  }

  const { messages, system } = req.body;
  if (!messages || !Array.isArray(messages)) {
    return res.status(400).json({ error: 'messages array required.' });
  }

  try {
    const upstream = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'content-type': 'application/json',
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01'
      },
      body: JSON.stringify({
        model: process.env.CLAUDE_MODEL || 'claude-opus-4-6',
        max_tokens: 1024,
        system: system || '',
        messages,
        stream: true
      })
    });

    if (!upstream.ok) {
      const err = await upstream.json().catch(() => ({}));
      return res.status(upstream.status).json({ error: (err.error && err.error.message) || 'Upstream error' });
    }

    // Pipe SSE stream straight through to the client
    res.setHeader('Content-Type', 'text/event-stream');
    res.setHeader('Cache-Control', 'no-cache');
    res.setHeader('X-Accel-Buffering', 'no');
    upstream.body.pipe(res);

  } catch (err) {
    console.error('Proxy error:', err);
    if (!res.headersSent) {
      res.status(502).json({ error: String(err) });
    }
  }
});

app.listen(PORT, () => {
  console.log(`COREPULSE running at http://localhost:${PORT}`);
  console.log(`API key loaded: ${process.env.ANTHROPIC_API_KEY ? 'YES' : 'NO — add it to .env'}`);
});
