/********************************************************************************
** Form generated from reading UI file 'joint_sliders.ui'
**
** Created: Tue Oct 27 20:46:24 2015
**      by: Qt User Interface Compiler version 4.8.1
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_JOINT_SLIDERS_H
#define UI_JOINT_SLIDERS_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QPushButton>
#include <QtGui/QSlider>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_JointSlidersUI
{
public:
    QPushButton *discardButton;
    QPushButton *sendButton;
    QLabel *frc_lab;
    QLabel *pos_lab;
    QSlider *AutoSendSlider;
    QLabel *AutoSendLabel;

    void setupUi(QWidget *JointSlidersUI)
    {
        if (JointSlidersUI->objectName().isEmpty())
            JointSlidersUI->setObjectName(QString::fromUtf8("JointSlidersUI"));
        JointSlidersUI->resize(413, 713);
        QSizePolicy sizePolicy(QSizePolicy::Preferred, QSizePolicy::Preferred);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(JointSlidersUI->sizePolicy().hasHeightForWidth());
        JointSlidersUI->setSizePolicy(sizePolicy);
        JointSlidersUI->setMinimumSize(QSize(300, 159));
        JointSlidersUI->setMaximumSize(QSize(100000, 100000));
        JointSlidersUI->setStyleSheet(QString::fromUtf8(""));
        discardButton = new QPushButton(JointSlidersUI);
        discardButton->setObjectName(QString::fromUtf8("discardButton"));
        discardButton->setGeometry(QRect(250, 10, 80, 30));
        QSizePolicy sizePolicy1(QSizePolicy::Minimum, QSizePolicy::MinimumExpanding);
        sizePolicy1.setHorizontalStretch(0);
        sizePolicy1.setVerticalStretch(0);
        sizePolicy1.setHeightForWidth(discardButton->sizePolicy().hasHeightForWidth());
        discardButton->setSizePolicy(sizePolicy1);
        sendButton = new QPushButton(JointSlidersUI);
        sendButton->setObjectName(QString::fromUtf8("sendButton"));
        sendButton->setGeometry(QRect(110, 10, 80, 30));
        sizePolicy1.setHeightForWidth(sendButton->sizePolicy().hasHeightForWidth());
        sendButton->setSizePolicy(sizePolicy1);
        frc_lab = new QLabel(JointSlidersUI);
        frc_lab->setObjectName(QString::fromUtf8("frc_lab"));
        frc_lab->setGeometry(QRect(270, 100, 66, 17));
        pos_lab = new QLabel(JointSlidersUI);
        pos_lab->setObjectName(QString::fromUtf8("pos_lab"));
        pos_lab->setGeometry(QRect(210, 220, 66, 17));
        AutoSendSlider = new QSlider(JointSlidersUI);
        AutoSendSlider->setObjectName(QString::fromUtf8("AutoSendSlider"));
        AutoSendSlider->setGeometry(QRect(20, 140, 30, 29));
        AutoSendSlider->setOrientation(Qt::Horizontal);
        AutoSendLabel = new QLabel(JointSlidersUI);
        AutoSendLabel->setObjectName(QString::fromUtf8("AutoSendLabel"));
        AutoSendLabel->setGeometry(QRect(60, 140, 66, 17));

        retranslateUi(JointSlidersUI);

        QMetaObject::connectSlotsByName(JointSlidersUI);
    } // setupUi

    void retranslateUi(QWidget *JointSlidersUI)
    {
        JointSlidersUI->setWindowTitle(QApplication::translate("JointSlidersUI", "Form", 0, QApplication::UnicodeUTF8));
        discardButton->setText(QApplication::translate("JointSlidersUI", "Discard", 0, QApplication::UnicodeUTF8));
        sendButton->setText(QApplication::translate("JointSlidersUI", "Send", 0, QApplication::UnicodeUTF8));
        frc_lab->setText(QApplication::translate("JointSlidersUI", "Force", 0, QApplication::UnicodeUTF8));
        pos_lab->setText(QApplication::translate("JointSlidersUI", "Position", 0, QApplication::UnicodeUTF8));
        AutoSendLabel->setText(QApplication::translate("JointSlidersUI", "AutoSend", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class JointSlidersUI: public Ui_JointSlidersUI {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_JOINT_SLIDERS_H
