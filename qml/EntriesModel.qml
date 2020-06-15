import QtQuick 2.9

SortedListModel {

    function compareFunction(a, b) {
        return getSortableName(a.credential).localeCompare(getSortableName(b.credential));
    }

    function getSortableName(credential) {
        return (settings.favorites.includes(credential.key) ? "0" : "1") + (credential.issuer || "") + (credential.name || "") + "/" + (credential.period || "");
    }

    function updateEntry(entry) {
        for (var j = 0; j < count; j++) {
            if (get(j).credential.key === entry.credential.key) {
                set(j, entry);
                return ;
            }
        }
        append(entry);
        sort();
    }

    function updateEntries(entries, cb) {
        // Update new ones
        for (var i = 0; i < entries.length; i++) {
            updateEntry(entries[i]);
        }
        cb();
    }

    function deleteEntry(key) {
        for (var j = 0; j < count; j++) {
            if (get(j).credential.key === key) {
                remove(j);
                return ;
            }
        }
    }

    function clearCode(key) {
        for (var j = 0; j < count; j++) {
            if (get(j).credential.key === key)
                setProperty(j, "code", null);

        }
    }

    compareFunc: compareFunction
    onDataChanged: sort()
    dynamicRoles: true
}
