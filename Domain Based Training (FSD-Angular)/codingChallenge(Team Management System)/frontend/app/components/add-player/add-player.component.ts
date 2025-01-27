import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { PlayerService } from '../../services/player.service'; // Import PlayerService
import { Player } from '../../models/player.model'; // Import Player model

@Component({
  selector: 'app-add-player',
  templateUrl: './add-player.component.html',
  styleUrls: ['./add-player.component.css']
})
export class AddPlayerComponent {
  player: Player = new Player(); // Create an empty player object
  errorMessage: string = ''; // Variable to display error messages
  successMessage: string = ''; // Variable to display success messages

  constructor(private playerService: PlayerService, private router: Router) {}

  // Submit the form data to add a player
  onSubmit(): void {
    if (this.validateForm()) {
      this.playerService.addPlayer(this.player).subscribe(
        () => {
          this.successMessage = 'Player added successfully!';
          setTimeout(() => {
            this.router.navigate(['/']); // Navigate back to player list after success
          }, 2000);
        },
        (error) => {
          this.errorMessage = 'Failed to add player. Please try again later.';
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
    this.player = new Player();
    this.errorMessage = '';
    this.successMessage = '';
  }
}
