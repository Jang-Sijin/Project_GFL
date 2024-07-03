using UnityEngine;
using UnityEditor;
using UnityEditor.AddressableAssets;
using UnityEditor.AddressableAssets.Settings;
using System.Collections.Generic;

public class ChangeAddressableNames : EditorWindow
{
    [MenuItem("Tools/Change Spine SkeletonData Asset Names to Uppercase")]
    static void Init()
    {
        ChangeAddressableNames window = (ChangeAddressableNames)EditorWindow.GetWindow(typeof(ChangeAddressableNames));
        window.Show();
    }

    void OnGUI()
    {
        GUILayout.Label("Change Spine SkeletonData Asset Names to Uppercase", EditorStyles.boldLabel);

        if (GUILayout.Button("Change Names"))
        {
            ChangeNames();
        }
    }

    void ChangeNames()
    {
        AddressableAssetSettings settings = AddressableAssetSettingsDefaultObject.Settings;

        if (settings == null)
        {
            Debug.LogError("Addressable settings not found. Make sure to create or load Addressable settings.");
            return;
        }

        bool changesMade = false;

        // Find the Spine_SkeletonData group
        foreach (var group in settings.groups)
        {
            if (group.Name == "Spine_SkeletonData")
            {
                List<AddressableAssetEntry> entries = new List<AddressableAssetEntry>(group.entries);

                foreach (var entry in entries)
                {
                    string newAddress = entry.address.ToUpper(); // 주소를 대문자로 변경
                    entry.SetAddress(newAddress);

                    settings.SetDirty(AddressableAssetSettings.ModificationEvent.EntryModified, entry, true);

                    Debug.LogFormat("Addressable name changed from {0} to {1}", entry.address, newAddress);

                    changesMade = true;
                }
            }
        }

        if (changesMade)
        {
            EditorUtility.SetDirty(settings);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log("Addressable names changed successfully.");
        }
        else
        {
            Debug.Log("No changes made.");
        }
    }
}
