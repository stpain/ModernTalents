

local name, addon = ...;

addon.Callbacks = {
    SavedVariables_OnInitialized = "ON_SAVED_VARIABLES_INITIALIZED",
    SavedVariables_OnReset = "ON_SAVED_VARIABLES_RESET",

    Specialization_OnSelected = "ON_SPECIALIZATION_SELECTED",

    Talent_OnPreviewPointsChanged = "ON_TALENT_PREVIEW_POINTS_CHANGED",
    Talent_OnMouseDown = "ON_TALENT_MOUSE_DOWN",

    Talent_OnTalentRecording = "ON_TALENT_RECORDING",
    Talent_OnTalentRecordTalentAdded = "ON_TALENT_RECORD_TALENT_ADDED",
    Talent_OnTalentRecordSelectionChanged = "ON_TALENT_RECORD_TALENT_SELECTION_CHANGED"

}

local callbacksToRegister = {}
for k, v in pairs(addon.Callbacks) do
    table.insert(callbacksToRegister, v)
end

addon.CallbackRegistry = CreateFromMixins(CallbackRegistryMixin)
addon.CallbackRegistry:OnLoad()
addon.CallbackRegistry:GenerateCallbackEvents(callbacksToRegister)