import { Component, OnInit } from '@angular/core';
import { PlayerService } from '../../services/player.service'; // Import PlayerService
import { Router } from '@angular/router'; // Import Router for navigation
import { Player } from '../../models/player.model'; // Import Player model

@Component({
  selector: 'app-player-list',
  templateUrl: './player-list.component.html',
  styleUrls: ['./player-list.component.css']
})
export class PlayerListComponent implements OnInit {
  players: Player[] = []; // Array to store the list of players
  errorMessage: string = ''; // Variable to display error messages

  constructor(private playerService: PlayerService, private router: Router) {}

  ngOnInit(): void {
    this.getPlayers(); // Fetch players when the component is initialized
  }

  // Fetch all players
  getPlayers(): void {
    this.playerService.getPlayers().subscribe(
      (data) => {
        this.players = data; // Store fetched players in the players array
      },
      (error) => {
        this.errorMessage = 'Failed to load players. Please try again later.'; // Display error message
      }
    );
  }

  // Delete a player by ID
  deletePlayer(playerId: number): void {
    if (confirm('Are you sure you want to delete this player?')) {
      this.playerService.deletePlayer(playerId).subscribe(
        () => {
          this.players = this.players.filter(player => player.playerId !== playerId); // Remove deleted player from list
        },
        (error) => {
          this.errorMessage = 'Failed to delete player. Please try again later.';
        }
      );
    }
  }

  // Navigate to the Add Player form
  addPlayer(): void {
    this.router.navigate(['/add-player']);
  }

  // Navigate to the Edit Player form
  editPlayer(playerId: number): void {
    this.router.navigate([`/edit-player/${playerId}`]);
  }
}
