import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { PlayerService } from '../../services/player.service'; // Import PlayerService
import { Player } from '../../models/player.model'; // Import Player model

@Component({
  selector: 'app-edit-player',
  templateUrl: './edit-player.component.html',
  styleUrls: ['./edit-player.component.css']
})
export class EditPlayerComponent implements OnInit {
  player: Player = new Player(); // Create an empty player object
  errorMessage: string = ''; // Variable to display error messages
  successMessage: string = ''; // Variable to display success messages
  playerId: number = 0; // Variable to hold the player ID

  constructor(private playerService: PlayerService, private route: ActivatedRoute, private router: Router) {}

  ngOnInit(): void {
    this.playerId = +this.route.snapshot.paramMap.get('id')!; // Fetch the player ID from the route
    this.getPlayerDetails(); // Fetch the player details to populate the form
  }

  // Fetch player details by ID
  getPlayerDetails(): void {
    this.playerService.getPlayerById(this.playerId).subscribe(
      (data) => {
        this.player = data; // Pre-fill the form with the player's current details
      },
      (error) => {
        this.errorMessage = 'Failed to fetch player details. Please try again later.';
      }
    );
  }

  // Submit the updated player details to the backend
  onSubmit(): void {
    if (this.validateForm()) {
      this.playerService.updatePlayer(this.playerId, this.player).subscribe(
        () => {
          this.successMessage = 'Player updated successfully!';
          setTimeout(() => {
            this.router.navigate(['/']); // Navigate back to player list after success
          }, 2000);
        },
        (error) => {
          this.errorMessage = 'Failed to update player. Please try again later.';
        }
      );
    }
  }

  // Validate the form before submission
  validateForm(): boolean {
    if (!this.player.playerName || !this.player.jerseyNumber || !this.player.role ||
        !this.player.totalMatches || !this.player.teamName || !this.player.countryStateName) {
      this.errorMessage = 'Please fill all required fields.';
      return false;
    }
    if (this.player.jerseyNumber <= 0) {
      this.errorMessage = 'Jersey number must be greater than 0.';
      return false;
    }
    return true;
  }

  // Reset the form fields
  resetForm(): void {
    this.getPlayerDetails(); // Reset to the original player details
    this.errorMessage = '';
    this.successMessage = '';
  }

  // Navigate back to the player list without making changes
  goBack(): void {
    this.router.navigate(['/']);
  }
}
