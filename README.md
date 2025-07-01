# 🩺 Script Médecin Illégal – ESX + ox_lib

Ce script ajoute un PNJ soigneur illégal à votre serveur **FiveM**. Le joueur peut interagir avec ce PNJ pour se soigner partiellement ou totalement, contre de l'argent. En cas de refus de paiement, le PNJ devient hostile et attaque le joueur.

---

## 📦 Fonctionnalités

- 🧠 Intégration **ESX** (`exports['es_extended']:getSharedObject()`)
- 🎯 Interface utilisateur via `ox_lib` (menu contextuel + input dialog)
- 💰 Paiement interactif avec confirmation via interface **OX**
- 🔫 Attaque du PNJ en cas de refus de paiement
- 💉 Effet de soin avec animation et effet visuel personnalisé
- 🧱 Configuration simple via `Config` (`touche`, `positions`, `prix`, `pourcentages`, etc.)

---

## 🛠️ Installation

1. Placez le dossier dans `resources/`
2. Ajoutez à votre `server.cfg` :
   ```bash
   ensure ynk_illegaldoctor

---

## 🩻 Fonctionnalité de soin

Lorsqu’un joueur sélectionne un soin :

Une progress bar s’affiche (via ox_lib)

Une boîte de confirmation de paiement s’ouvre

Si accepté, déclenche un TriggerServerEvent pour retirer l'argent et appliquer le soin

Si refusé, le PNJ sort une arme et attaque le joueur

---

## 🔫 Système d'attaque

Le PNJ :

Reçoit un pistolet

Engage le combat avec TaskCombatPed

Attaque pendant 5 secondes

Perd ensuite son arme et redevient passif

---

## 🔐 Licence

Ce script est open-source et destiné à un usage communautaire. Toute revente est strictement interdite sans autorisation.
