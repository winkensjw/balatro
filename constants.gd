extends Node

# Save Manager
const LOADING_SCREENE_SCENE_PATH: String = "res://Common/SceneManager/LoadingScreen/loading_screen.tscn"
const SAVE_MANAGER_SETTINGS_RESOURCE_PATH: String = "res://Common/SaveManager/Data/save_manager_settings.tres"

# Audio
const AUDIO_SCENE_PATH: String = "res://Entities/Audio/audio.tscn"
const MUSIC_BANK_NAME: String = "music"
const MUSIC_TRACK_BACKGROUND_MUSIC_NAME: String = "background_music"
const SOUND_BANK_NAME: String = "sound"
const SOUND_TRACK_CARD_SOUND: String = "card_sound"

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
const CARD_WIDTH = 142
const CARD_UI_SCENE_PATH: String = "res://Entities/Game/Card/card_ui.tscn"
const CARD_SCENE_DICT = {
	Card.Suit.SPADES:
	{
		Card.Rank.A: "res://Entities/Game/Card/Resources/Spades/12_A_spades.tres",
		Card.Rank.K: "res://Entities/Game/Card/Resources/Spades/11_K_spades.tres",
		Card.Rank.Q: "res://Entities/Game/Card/Resources/Spades/10_Q_spades.tres",
		Card.Rank.J: "res://Entities/Game/Card/Resources/Spades/9_J_spades.tres",
		Card.Rank.TEN: "res://Entities/Game/Card/Resources/Spades/8_10_spades.tres",
		Card.Rank.NINE: "res://Entities/Game/Card/Resources/Spades/7_9_spades.tres",
		Card.Rank.EIGHT: "res://Entities/Game/Card/Resources/Spades/6_8_spades.tres",
		Card.Rank.SEVEN: "res://Entities/Game/Card/Resources/Spades/5_7_spades.tres",
		Card.Rank.SIX: "res://Entities/Game/Card/Resources/Spades/4_6_spades.tres",
		Card.Rank.FIVE: "res://Entities/Game/Card/Resources/Spades/3_5_spades.tres",
		Card.Rank.FOUR: "res://Entities/Game/Card/Resources/Spades/2_4_spades.tres",
		Card.Rank.THREE: "res://Entities/Game/Card/Resources/Spades/1_3_spades.tres",
		Card.Rank.TWO: "res://Entities/Game/Card/Resources/Spades/0_2_spades.tres"
	},
	Card.Suit.HEARTS:
	{
		Card.Rank.A: "res://Entities/Game/Card/Resources/Hearts/12_A_hearts.tres",
		Card.Rank.K: "res://Entities/Game/Card/Resources/Hearts/11_K_hearts.tres",
		Card.Rank.Q: "res://Entities/Game/Card/Resources/Hearts/10_Q_hearts.tres",
		Card.Rank.J: "res://Entities/Game/Card/Resources/Hearts/9_J_hearts.tres",
		Card.Rank.TEN: "res://Entities/Game/Card/Resources/Hearts/8_10_hearts.tres",
		Card.Rank.NINE: "res://Entities/Game/Card/Resources/Hearts/7_9_hearts.tres",
		Card.Rank.EIGHT: "res://Entities/Game/Card/Resources/Hearts/6_8_hearts.tres",
		Card.Rank.SEVEN: "res://Entities/Game/Card/Resources/Hearts/5_7_hearts.tres",
		Card.Rank.SIX: "res://Entities/Game/Card/Resources/Hearts/4_6_hearts.tres",
		Card.Rank.FIVE: "res://Entities/Game/Card/Resources/Hearts/3_5_hearts.tres",
		Card.Rank.FOUR: "res://Entities/Game/Card/Resources/Hearts/2_4_hearts.tres",
		Card.Rank.THREE: "res://Entities/Game/Card/Resources/Hearts/1_3_hearts.tres",
		Card.Rank.TWO: "res://Entities/Game/Card/Resources/Hearts/0_2_hearts.tres"
	},
	Card.Suit.CLUBS:
	{
		Card.Rank.A: "res://Entities/Game/Card/Resources/Clubs/12_A_clubs.tres",
		Card.Rank.K: "res://Entities/Game/Card/Resources/Clubs/11_K_clubs.tres",
		Card.Rank.Q: "res://Entities/Game/Card/Resources/Clubs/10_Q_clubs.tres",
		Card.Rank.J: "res://Entities/Game/Card/Resources/Clubs/9_J_clubs.tres",
		Card.Rank.TEN: "res://Entities/Game/Card/Resources/Clubs/8_10_clubs.tres",
		Card.Rank.NINE: "res://Entities/Game/Card/Resources/Clubs/7_9_clubs.tres",
		Card.Rank.EIGHT: "res://Entities/Game/Card/Resources/Clubs/6_8_clubs.tres",
		Card.Rank.SEVEN: "res://Entities/Game/Card/Resources/Clubs/5_7_clubs.tres",
		Card.Rank.SIX: "res://Entities/Game/Card/Resources/Clubs/4_6_clubs.tres",
		Card.Rank.FIVE: "res://Entities/Game/Card/Resources/Clubs/3_5_clubs.tres",
		Card.Rank.FOUR: "res://Entities/Game/Card/Resources/Clubs/2_4_clubs.tres",
		Card.Rank.THREE: "res://Entities/Game/Card/Resources/Clubs/1_3_clubs.tres",
		Card.Rank.TWO: "res://Entities/Game/Card/Resources/Clubs/0_2_clubs.tres"
	},
	Card.Suit.DIAMONDS:
	{
		Card.Rank.A: "res://Entities/Game/Card/Resources/Diamonds/12_A_diamonds.tres",
		Card.Rank.K: "res://Entities/Game/Card/Resources/Diamonds/11_K_diamonds.tres",
		Card.Rank.Q: "res://Entities/Game/Card/Resources/Diamonds/10_Q_diamonds.tres",
		Card.Rank.J: "res://Entities/Game/Card/Resources/Diamonds/9_J_diamonds.tres",
		Card.Rank.TEN: "res://Entities/Game/Card/Resources/Diamonds/8_10_diamonds.tres",
		Card.Rank.NINE: "res://Entities/Game/Card/Resources/Diamonds/7_9_diamonds.tres",
		Card.Rank.EIGHT: "res://Entities/Game/Card/Resources/Diamonds/6_8_diamonds.tres",
		Card.Rank.SEVEN: "res://Entities/Game/Card/Resources/Diamonds/5_7_diamonds.tres",
		Card.Rank.SIX: "res://Entities/Game/Card/Resources/Diamonds/4_6_diamonds.tres",
		Card.Rank.FIVE: "res://Entities/Game/Card/Resources/Diamonds/3_5_diamonds.tres",
		Card.Rank.FOUR: "res://Entities/Game/Card/Resources/Diamonds/2_4_diamonds.tres",
		Card.Rank.THREE: "res://Entities/Game/Card/Resources/Diamonds/1_3_diamonds.tres",
		Card.Rank.TWO: "res://Entities/Game/Card/Resources/Diamonds/0_2_diamonds.tres"
	}
}

#Decks
const DECK_UI_SCENE_PATH: String = "res://Entities/Game/Decks/deck_ui.tscn"
const STANDARD_DECK_RESOURCE_PATH: String = "res://Entities/Game/Decks/Resources/standard_deck.tres"
