/********************************************************************************
** Form generated from reading UI file 'single_joint_slider.ui'
**
** Created: Tue Oct 27 20:46:25 2015
**      by: Qt User Interface Compiler version 4.8.1
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_SINGLE_JOINT_SLIDER_H
#define UI_SINGLE_JOINT_SLIDER_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QScrollBar>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_SingleJointSliderUI
{
public:
    QLabel *JointName;
    QLabel *l_hint;
    QLabel *r_hint;
    QScrollBar *position_slider;
    QLabel *display_pos;
    QLabel *display_frc;

    void setupUi(QWidget *SingleJointSliderUI)
    {
        if (SingleJointSliderUI->objectName().isEmpty())
            SingleJointSliderUI->setObjectName(QString::fromUtf8("SingleJointSliderUI"));
        SingleJointSliderUI->resize(460, 26);
        QSizePolicy sizePolicy(QSizePolicy::Preferred, QSizePolicy::Preferred);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(SingleJointSliderUI->sizePolicy().hasHeightForWidth());
        SingleJointSliderUI->setSizePolicy(sizePolicy);
        SingleJointSliderUI->setMinimumSize(QSize(460, 26));
        SingleJointSliderUI->setMaximumSize(QSize(100000, 100000));
        SingleJointSliderUI->setSizeIncrement(QSize(0, 0));
        SingleJointSliderUI->setLayoutDirection(Qt::LeftToRight);
        SingleJointSliderUI->setStyleSheet(QString::fromUtf8(""));
        JointName = new QLabel(SingleJointSliderUI);
        JointName->setObjectName(QString::fromUtf8("JointName"));
        JointName->setGeometry(QRect(10, 5, 81, 16));
        JointName->setTextFormat(Qt::AutoText);
        l_hint = new QLabel(SingleJointSliderUI);
        l_hint->setObjectName(QString::fromUtf8("l_hint"));
        l_hint->setGeometry(QRect(110, 3, 100, 20));
        l_hint->setStyleSheet(QString::fromUtf8("font: 10pt \"Ubuntu\";"));
        r_hint = new QLabel(SingleJointSliderUI);
        r_hint->setObjectName(QString::fromUtf8("r_hint"));
        r_hint->setGeometry(QRect(210, 3, 101, 20));
        r_hint->setAlignment(Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter);
        position_slider = new QScrollBar(SingleJointSliderUI);
        position_slider->setObjectName(QString::fromUtf8("position_slider"));
        position_slider->setGeometry(QRect(90, 3, 241, 20));
        position_slider->setMinimumSize(QSize(210, 0));
        position_slider->setStyleSheet(QString::fromUtf8("QScrollBar:horizontal {background: transparent}"));
        position_slider->setMaximum(511);
        position_slider->setOrientation(Qt::Horizontal);
        position_slider->setInvertedAppearance(true);
        position_slider->setInvertedControls(false);
        display_pos = new QLabel(SingleJointSliderUI);
        display_pos->setObjectName(QString::fromUtf8("display_pos"));
        display_pos->setGeometry(QRect(340, 3, 50, 20));
        display_frc = new QLabel(SingleJointSliderUI);
        display_frc->setObjectName(QString::fromUtf8("display_frc"));
        display_frc->setGeometry(QRect(400, 3, 50, 20));

        retranslateUi(SingleJointSliderUI);

        QMetaObject::connectSlotsByName(SingleJointSliderUI);
    } // setupUi

    void retranslateUi(QWidget *SingleJointSliderUI)
    {
        SingleJointSliderUI->setWindowTitle(QApplication::translate("SingleJointSliderUI", "Form", 0, QApplication::UnicodeUTF8));
        JointName->setText(QApplication::translate("SingleJointSliderUI", "name", 0, QApplication::UnicodeUTF8));
        l_hint->setText(QApplication::translate("SingleJointSliderUI", "TextLabel", 0, QApplication::UnicodeUTF8));
        r_hint->setText(QApplication::translate("SingleJointSliderUI", "TextLabel", 0, QApplication::UnicodeUTF8));
        display_pos->setText(QApplication::translate("SingleJointSliderUI", "TextLabel", 0, QApplication::UnicodeUTF8));
        display_frc->setText(QApplication::translate("SingleJointSliderUI", "TextLabel", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class SingleJointSliderUI: public Ui_SingleJointSliderUI {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_SINGLE_JOINT_SLIDER_H
