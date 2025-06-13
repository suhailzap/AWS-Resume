// API endpoint for visitor counter
const API_ENDPOINT = 'https://your-api-gateway-url.execute-api.region.amazonaws.com/prod';

// Update visitor count
async function updateVisitorCount() {
    try {
        const response = await fetch(`${API_ENDPOINT}/visitor-count`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        
        if (!response.ok) {
            throw new Error('Failed to update visitor count');
        }

        const data = await response.json();
        document.getElementById('visitorCount').textContent = data.count;
    } catch (error) {
        console.error('Error updating visitor count:', error);
        document.getElementById('visitorCount').textContent = 'Error';
    }
}

// Handle contact form submission
document.getElementById('contactForm').addEventListener('submit', async (e) => {
    e.preventDefault();

    const formData = {
        name: document.getElementById('name').value,
        email: document.getElementById('email').value,
        message: document.getElementById('message').value
    };

    try {
        const response = await fetch(`${API_ENDPOINT}/contact`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        });

        if (!response.ok) {
            throw new Error('Failed to send message');
        }

        alert('Message sent successfully!');
        e.target.reset();
    } catch (error) {
        console.error('Error sending message:', error);
        alert('Failed to send message. Please try again later.');
    }
});

// Smooth scrolling for navigation links
document.querySelectorAll('nav a').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        const section = document.querySelector(this.getAttribute('href'));
        section.scrollIntoView({
            behavior: 'smooth'
        });
    });
});

// Initialize visitor count when page loads
document.addEventListener('DOMContentLoaded', updateVisitorCount); 