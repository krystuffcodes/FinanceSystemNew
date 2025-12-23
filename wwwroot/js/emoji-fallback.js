// Emoji and Icon Fallback System
window.emojiSupport = {
    // Test if browser supports emojis properly
    testEmojiSupport: function() {
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');
        
        // Test with a simple emoji
        ctx.textBaseline = 'top';
        ctx.font = '32px Arial';
        ctx.fillText('??', 0, 0);
        
        return ctx.getImageData(16, 16, 1, 1).data[0] !== 0;
    },

    // Fallback icon mapping for when emojis don't work
    iconFallbacks: {
        '??': '$',
        '??': '?',
        '??': '!',
        '??': '?',
        '??': '?',
        '??': '?',
        '??': '?',
        '?': '?',
        '??': '?',
        '??': 'N',
        '?': '?',
        '?': '?',
        '??': '?',
        '??': '?',
        '??': '?',
        '??': '$',
        '?': '?',
        '?': '?',
        '??': '?'
    },

    // Replace emojis with fallback icons
    applyFallbacks: function() {
        if (this.testEmojiSupport()) return;
        
        document.body.classList.add('no-emoji');
        
        // Find all emoji elements and replace them
        const emojiElements = document.querySelectorAll('.kpi-icon, .chart-icon, .small-icon, .placeholder-icon');
        
        emojiElements.forEach(element => {
            const originalText = element.textContent;
            if (this.iconFallbacks[originalText]) {
                element.textContent = this.iconFallbacks[originalText];
                element.style.fontWeight = 'bold';
                element.style.fontSize = '1.5rem';
            }
        });
    },

    // Initialize the system
    init: function() {
        // Run when DOM is loaded
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.applyFallbacks());
        } else {
            this.applyFallbacks();
        }
        
        // Also run when Blazor components are updated
        const observer = new MutationObserver(() => {
            setTimeout(() => this.applyFallbacks(), 100);
        });
        
        observer.observe(document.body, {
            childList: true,
            subtree: true
        });
    }
};

// Initialize when script loads
window.emojiSupport.init();