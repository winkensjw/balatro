# =============================================================================
# ModalDialog.gd
# =============================================================================
# This script defines a base class for all modal dialogs in the game.
#
# @author winkensjw
# @version 1.0
# =============================================================================
class_name ModalDialog
extends PanelContainer


func close(animated: bool) -> void:
	Events.close_dialog.emit(self, animated)
