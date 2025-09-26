let isLeaderboardVisible = false;
let isTop3Visible = false;

// Listen for NUI messages
window.addEventListener('message', function(event) {
    const data = event.data;

    switch(data.action) {
        case 'showLeaderboard':
            showLeaderboard(data.data, data.playerStats);
            break;
        case 'hideLeaderboard':
            hideLeaderboard();
            break;
        case 'updateData':
            updateLeaderboardData(data.data, data.playerStats);
            break;
        case 'showTop3':
            showTop3(data.data);
            break;
        case 'hideTop3':
            hideTop3();
            break;
        case 'updateTop3':
            updateTop3Data(data.data);
            break;
    }
});

// Show leaderboard
function showLeaderboard(leaderboardData, playerStats) {
    const container = document.getElementById('leaderboard');
    container.classList.add('show');
    isLeaderboardVisible = true;

    updatePlayerStats(playerStats);
    populateLeaderboard(leaderboardData);
}

// Hide leaderboard
function hideLeaderboard() {
    const container = document.getElementById('leaderboard');
    container.classList.remove('show');
    isLeaderboardVisible = false;
}

// Update player stats
function updatePlayerStats(playerStats) {
    if (!playerStats) return;

    document.getElementById('player-name').textContent = playerStats.playername || 'Unknown';
    document.getElementById('player-kills').textContent = playerStats.kills || 0;
    document.getElementById('player-deaths').textContent = playerStats.death || 0;
    document.getElementById('player-kda').textContent = playerStats.kda || '0.00';
    document.getElementById('player-rank').textContent = playerStats.rank || 'Unranked';
}

// Populate leaderboard
function populateLeaderboard(data) {
    const tableBody = document.getElementById('leaderboard-data');
    tableBody.innerHTML = '';

    data.forEach((player, index) => {
        const row = document.createElement('div');
        row.className = 'leaderboard-row';

        if (index < 3) {
            row.classList.add('top-3');
        }

        const playerName = player.playername || 'Unknown';
        const kda = player.kda || '0.00';
        const rank = player.rank || 'Unranked';

        row.innerHTML = `
            <div class="rank">${index + 1}</div>
            <div class="player-name">${playerName}</div>
            <div class="kills">${player.kills || 0}</div>
            <div class="deaths">${player.death || 0}</div>
            <div class="kda">${kda}</div>
            <div class="player-rank">${rank}</div>
        `;

        tableBody.appendChild(row);
    });
}

// Update leaderboard data
function updateLeaderboardData(leaderboardData, playerStats) {
    if (isLeaderboardVisible) {
        updatePlayerStats(playerStats);
        populateLeaderboard(leaderboardData);
    }
}

// Show TOP 3 simple text display
function showTop3(data) {
    isTop3Visible = true;
    const container = document.getElementById('top3-container');
    container.classList.add('show');
    populateTop3(data);
}

// Hide TOP 3 simple text display
function hideTop3() {
    isTop3Visible = false;
    const container = document.getElementById('top3-container');
    if (container) {
        container.classList.remove('show');
    }
}

// Populate TOP 3 simple text list
function populateTop3(data) {
    const listElement = document.getElementById('top3-list');
    if (!listElement) return;

    let html = '';
    data.forEach((player, index) => {
        const playerName = player.playername || 'Unknown';
        const kda = player.kda || '0.00';
        const rankClass = index === 0 ? 'top3-rank-1' : (index === 1 ? 'top3-rank-2' : 'top3-rank-3');

        html += `<div class="top3-player ${rankClass}">
            ${index + 1}. ${playerName} - ${player.kills || 0}Kill / ${player.death || 0}Death (${kda})
        </div>`;
    });

    listElement.innerHTML = html;
}

// Update TOP 3 data
function updateTop3Data(data) {
    if (isTop3Visible) {
        populateTop3(data);
    }
}

// Close leaderboard function
function closeLeaderboard() {
    hideLeaderboard();
    fetch(`https://${GetParentResourceName()}/closeLeaderboard`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    });
}

// Handle ESC key
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape' && isLeaderboardVisible) {
        closeLeaderboard();
    }
});

// Prevent context menu
document.addEventListener('contextmenu', function(e) {
    e.preventDefault();
});