/*
 * Copyright (C) 2017 Stefano Verzegnassi <verzegnassi.stefano@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import Ubuntu.Components 1.3

import "Components" as Components

Page {
    id: rootItem

    header: PageHeader {
        title: i18n.tr("Settings")
    }

    AuthenticationHandler {
        id: authHandler
        serviceName: root.applicationName
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        anchors.topMargin: parent.header.height

        Item {
            width: scrollView.width
            height: layout.height

            Column {
                id: layout
                anchors.horizontalCenter: parent.horizontalCenter
                width: Math.min(parent.width, units.gu(80))

                Components.SectionDivider {
                    text: i18n.tr("Parental control")
                }

                ListItem {
                    ListItemLayout {
                        anchors.centerIn: parent
                        title.text: i18n.tr("Hide adult-oriented content")

                        Switch {
                            SlotsLayout.position: SlotsLayout.Last
                            checked: settings.hideNsfw

                            onClicked: {
                                authHandler.authenticationSucceeded.connect(function() {
                                    settings.hideNsfw = checked
                                })

                                authHandler.authenticationAborted.connect(function() {
                                    checked = !checked
                                })

                                authHandler.authenticate(i18n.tr("You need to authenticate in order to change this setting."))
                            }
                        }
                    }
                }

                Components.SectionDivider {
                    text: i18n.tr("Developers")
                }

                ListItem {
                    onClicked: Qt.openUrlExternally("https://open.uappexplorer.com/manage")
                    ListItemLayout {
                        anchors.centerIn: parent
                        title.text: i18n.tr("Manage your apps on OpenStore")
                        ProgressionSlot {}
                    }
                }

                Components.SectionDivider {
                    text: i18n.tr("About OpenStore")
                }

                ListItem {
                    onClicked: Qt.openUrlExternally("https://github.com/UbuntuOpenStore/openstore-app")
                    ListItemLayout {
                        anchors.centerIn: parent
                        title.text: i18n.tr("Source Code")
                        ProgressionSlot {}
                    }
                }

                ListItem {
                    onClicked: Qt.openUrlExternally("https://github.com/UbuntuOpenStore/openstore-meta/issues/new")
                    ListItemLayout {
                        anchors.centerIn: parent
                        title.text: i18n.tr("Report an issue")
                        ProgressionSlot {}
                    }
                }
            }
        }
    }
}
