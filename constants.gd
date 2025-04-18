extends Node

# Save Manager
const LOADING_SCREENE_SCENE_PATH: String = "res://Common/SceneManager/LoadingScreen/loading_screen.tscn"
const SAVE_MANAGER_SETTINGS_RESOURCE_PATH: String = "res://Common/SaveManager/Data/save_manager_settings.tres"

# Audio
const AUDIO_SCENE_PATH: String = "res://Entities/Audio/audio.tscn"
const MUSIC_BANK_NAME: String = "music"
const MUSIC_TRACK_BACKGROUND_MUSIC_NAME: String = "background_music"

# UI Elements
const CRT_FTILER_SCENE_PATH: String = "res://Common/UiElements/crt_filter.tscn"

# Entities
const GAME_SCENE_PATH: String = "res://Entities/Game/game.tscn"

# Main Menu
const MAIN_MENU_SCENE_PATH: String = "res://Entities/MainMenu/main_menu.tscn"
const OPTIONS_DIALOG_SCENE_PATH: String = "res://Entities/MainMenu/Dialogs/options_dialog.tscn"
const SETTINGS_DIALOG_SCENE_PATH: String = "res://Entities/MainMenu/Dialogs/settings_dialog.tscn"
const GAME_SETUP_DIALOG_SCENE_PATH: String = "res://Entities/MainMenu/Dialogs/game_setup_dialog.tscn"

# Game State Panel
const CHOOSE_BLIND_CONTAINER_SCENE_PATH: String = "res://Entities/Game/GameStatePanel/ChooseBlindContainer/choose_blind_container.tscn"
const CURRENT_BLIND_CONTAINER_SCENE_PATH: String = "res://Entities/Game/GameStatePanel/CurrentBlindContainer/current_blind_container.tscn"
const SHOP_SIGN_CONTAINER_SCENE_PATH: String = "res://Entities/Game/GameStatePanel/ShopSignContainer/shop_sign_container.tscn"

# Cards
const CARD_UI_SCENE_PATH: String = "res://Entities/Game/Card/card_ui.tscn"
const CARD_SCENE_DICT = {
	GameController.Suit.SPADES:
	{
		GameController.Rank.A: "res://Entities/Game/Card/Resources/Spades/12_A_spades.tres",
		GameController.Rank.K: "res://Entities/Game/Card/Resources/Spades/11_K_spades.tres",
		GameController.Rank.Q: "res://Entities/Game/Card/Resources/Spades/10_Q_spades.tres",
		GameController.Rank.J: "res://Entities/Game/Card/Resources/Spades/9_J_spades.tres",
		GameController.Rank.TEN: "res://Entities/Game/Card/Resources/Spades/8_10_spades.tres",
		GameController.Rank.NINE: "res://Entities/Game/Card/Resources/Spades/7_9_spades.tres",
		GameController.Rank.EIGHT: "res://Entities/Game/Card/Resources/Spades/6_8_spades.tres",
		GameController.Rank.SEVEN: "res://Entities/Game/Card/Resources/Spades/5_7_spades.tres",
		GameController.Rank.SIX: "res://Entities/Game/Card/Resources/Spades/4_6_spades.tres",
		GameController.Rank.FIVE: "res://Entities/Game/Card/Resources/Spades/3_5_spades.tres",
		GameController.Rank.FOUR: "res://Entities/Game/Card/Resources/Spades/2_4_spades.tres",
		GameController.Rank.THREE: "res://Entities/Game/Card/Resources/Spades/1_3_spades.tres",
		GameController.Rank.TWO: "res://Entities/Game/Card/Resources/Spades/0_2_spades.tres"
	},
	GameController.Suit.HEARTS:
	{
		GameController.Rank.A: "res://Entities/Game/Card/Resources/Hearts/12_A_hearts.tres",
		GameController.Rank.K: "res://Entities/Game/Card/Resources/Hearts/11_K_hearts.tres",
		GameController.Rank.Q: "res://Entities/Game/Card/Resources/Hearts/10_Q_hearts.tres",
		GameController.Rank.J: "res://Entities/Game/Card/Resources/Hearts/9_J_hearts.tres",
		GameController.Rank.TEN: "res://Entities/Game/Card/Resources/Hearts/8_10_hearts.tres",
		GameController.Rank.NINE: "res://Entities/Game/Card/Resources/Hearts/7_9_hearts.tres",
		GameController.Rank.EIGHT: "res://Entities/Game/Card/Resources/Hearts/6_8_hearts.tres",
		GameController.Rank.SEVEN: "res://Entities/Game/Card/Resources/Hearts/5_7_hearts.tres",
		GameController.Rank.SIX: "res://Entities/Game/Card/Resources/Hearts/4_6_hearts.tres",
		GameController.Rank.FIVE: "res://Entities/Game/Card/Resources/Hearts/3_5_hearts.tres",
		GameController.Rank.FOUR: "res://Entities/Game/Card/Resources/Hearts/2_4_hearts.tres",
		GameController.Rank.THREE: "res://Entities/Game/Card/Resources/Hearts/1_3_hearts.tres",
		GameController.Rank.TWO: "res://Entities/Game/Card/Resources/Hearts/0_2_hearts.tres"
	},
	GameController.Suit.CLUBS:
	{
		GameController.Rank.A: "res://Entities/Game/Card/Resources/Clubs/12_A_clubs.tres",
		GameController.Rank.K: "res://Entities/Game/Card/Resources/Clubs/11_K_clubs.tres",
		GameController.Rank.Q: "res://Entities/Game/Card/Resources/Clubs/10_Q_clubs.tres",
		GameController.Rank.J: "res://Entities/Game/Card/Resources/Clubs/9_J_clubs.tres",
		GameController.Rank.TEN: "res://Entities/Game/Card/Resources/Clubs/8_10_clubs.tres",
		GameController.Rank.NINE: "res://Entities/Game/Card/Resources/Clubs/7_9_clubs.tres",
		GameController.Rank.EIGHT: "res://Entities/Game/Card/Resources/Clubs/6_8_clubs.tres",
		GameController.Rank.SEVEN: "res://Entities/Game/Card/Resources/Clubs/5_7_clubs.tres",
		GameController.Rank.SIX: "res://Entities/Game/Card/Resources/Clubs/4_6_clubs.tres",
		GameController.Rank.FIVE: "res://Entities/Game/Card/Resources/Clubs/3_5_clubs.tres",
		GameController.Rank.FOUR: "res://Entities/Game/Card/Resources/Clubs/2_4_clubs.tres",
		GameController.Rank.THREE: "res://Entities/Game/Card/Resources/Clubs/1_3_clubs.tres",
		GameController.Rank.TWO: "res://Entities/Game/Card/Resources/Clubs/0_2_clubs.tres"
	},
	GameController.Suit.DIAMONDS:
	{
		GameController.Rank.A: "res://Entities/Game/Card/Resources/Diamonds/12_A_diamonds.tres",
		GameController.Rank.K: "res://Entities/Game/Card/Resources/Diamonds/11_K_diamonds.tres",
		GameController.Rank.Q: "res://Entities/Game/Card/Resources/Diamonds/10_Q_diamonds.tres",
		GameController.Rank.J: "res://Entities/Game/Card/Resources/Diamonds/9_J_diamonds.tres",
		GameController.Rank.TEN: "res://Entities/Game/Card/Resources/Diamonds/8_10_diamonds.tres",
		GameController.Rank.NINE: "res://Entities/Game/Card/Resources/Diamonds/7_9_diamonds.tres",
		GameController.Rank.EIGHT: "res://Entities/Game/Card/Resources/Diamonds/6_8_diamonds.tres",
		GameController.Rank.SEVEN: "res://Entities/Game/Card/Resources/Diamonds/5_7_diamonds.tres",
		GameController.Rank.SIX: "res://Entities/Game/Card/Resources/Diamonds/4_6_diamonds.tres",
		GameController.Rank.FIVE: "res://Entities/Game/Card/Resources/Diamonds/3_5_diamonds.tres",
		GameController.Rank.FOUR: "res://Entities/Game/Card/Resources/Diamonds/2_4_diamonds.tres",
		GameController.Rank.THREE: "res://Entities/Game/Card/Resources/Diamonds/1_3_diamonds.tres",
		GameController.Rank.TWO: "res://Entities/Game/Card/Resources/Diamonds/0_2_diamonds.tres"
	}
}

#Decks
const DECK_UI_SCENE_PATH: String = "res://Entities/Game/Decks/deck_ui.tscn"
const STANDARD_DECK_RESOURCE_PATH: String = "res://Entities/Game/Decks/Resources/standard_deck.tres"
