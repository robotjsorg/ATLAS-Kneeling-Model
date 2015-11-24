/**
 ********************************************************************************************************
 * @file    task_layout.cpp
 * @brief   task_layout widget class
 * @details Used to display the task_layout
 ********************************************************************************************************
 */

/*** INCLUDE FILES ***/
#include <drc_gui/task_layout.hpp>

/************************* GUI *************************/

/**
 * @note   None
 */
TaskLayout::TaskLayout(QWidget *parent) :

		QWidget(parent), ui(new Ui::TaskLayoutUI)
{

	ui->setupUi(this); //display the UI

//	PerceptionViewer* perception_viewer = PerceptionViewer::GetInstance();
//	QWidget *perception_viewer_widget = perception_viewer->NewUI();
//	ui->CenterLayout->addWidget(	perception_viewer_widget,0,0);
//
//	PumpControl* pump_control = PumpControl::GetInstance();
//	QWidget *pump_control_widget = pump_control->NewUI();
//	ui->PumpControlLayout->addWidget(	pump_control_widget,0,0);
//
//	TaskControl* task_control = TaskControl::GetInstance();
//	QWidget *task_control_widget = task_control->NewUI();
//	ui->TaskControlLayout->addWidget(	task_control_widget,0,0);
//
//	PumpStatus* pump_status = PumpStatus::GetInstance();
//	QWidget *pump_status_widget = pump_status->NewUI();
//	ui->PumpStatusLayout->addWidget(	pump_status_widget,0,0);
//
//	JointSliders* joint_sliders = JointSliders::GetInstance();
//	QWidget *joint_sliders_widget = joint_sliders->NewUI();
//	ui->JointSliderLayout->addWidget(	joint_sliders_widget,0,0);
//
//	ModeSelector* mode_selector = ModeSelector::GetInstance();
//	QWidget *mode_selector_widget = mode_selector->NewUI();
//	ui->ModeSelectLayout->addWidget(	mode_selector_widget,0,0);
//
//
//	SimplifiedHandControl* simplified_hand_control = SimplifiedHandControl::GetInstance();
//	QWidget *hand_control_widget = simplified_hand_control->NewUI();
//	ui->HandControlLayout->addWidget(	hand_control_widget,0,0);
//
//	SriHandControl* sri_hand_control = SriHandControl::GetInstance();
//	QWidget *sri_hand_control_widget = sri_hand_control->NewUI();
//	//ui->SriHandControlLayout->addWidget(	sri_hand_control_widget,0,0);
//
//	StepControl* step_control = StepControl::GetInstance();
//	QWidget *step_control_widget = step_control->NewUI();
//	//ui->StepControlLayout->addWidget(	step_control_widget,0,0);
//
//	CommStatus* comm_status = CommStatus::GetInstance();
//	QWidget *comm_status_widget = comm_status->NewUI();
//	ui->CommStatusLayout->addWidget(	comm_status_widget,0,0);
//
//	PingStatus* ping_status = PingStatus::GetInstance();
//	QWidget *ping_status_widget = ping_status->NewUI();
//	ui->PingStatusLayout->addWidget(	ping_status_widget,0,0);
//
//	SteeringSlider* steering_slider = SteeringSlider::GetInstance();
//	QWidget *steering_slider_widget = steering_slider->NewUI();
//	//ui->SteeringSliderLayout->addWidget(	steering_slider_widget,0,0);
//
//
//	ImageViewer* image_viewer = ImageViewer::GetInstance();
//	QWidget *image_viewer_widget = image_viewer->NewUI();
////	ui->CenterLayout->addWidget(	image_viewer_widget,0,0);
//
//	ComCopWidget* comcopwidget = ComCopWidget::GetInstance();
//	QWidget *com_cop_widget = comcopwidget->NewUI();
//	ui->ComCopLayout->addWidget(	com_cop_widget,0,0);
//
//
//
//
//	ErrorStatus* errorstatuswidget = ErrorStatus::GetInstance();
//	QWidget *error_status_widget = errorstatuswidget->NewUI();
//	ui->ErrorStatusLayout->addWidget(	error_status_widget,0,0);



	QGridLayout *perception_layout = new QGridLayout;
	ui->PerceptionFrame->setLayout(perception_layout);
	PerceptionViewer* perception_viewer = PerceptionViewer::GetInstance();
	QWidget *perception_viewer_widget = perception_viewer->NewUI();
	perception_layout->addWidget(perception_viewer_widget);
	perception_layout->setAlignment(perception_viewer_widget, Qt::AlignCenter);
	PerceptionViewerGUI* gui_instance= (PerceptionViewerGUI*)perception_viewer_widget;
	gui_instance->image_view_gui->SetAsMain();

	QGridLayout *task_layout = new QGridLayout;
	ui->TaskWidget->setLayout(task_layout);
	TaskControl* task_control = TaskControl::GetInstance();
	QWidget *task_control_widget = task_control->NewUI();
	task_layout->addWidget(task_control_widget);

	QGridLayout *stop_layout = new QGridLayout;
	ui->StopWidget->setLayout(stop_layout);
	PumpControl* pump_control = PumpControl::GetInstance();
	QWidget *pump_control_widget = pump_control->NewUI();
	stop_layout->addWidget(pump_control_widget);

	QVBoxLayout *status_layout = new QVBoxLayout;
	ui->StatusWidget->setLayout(status_layout);

	/*
	CommStatus* comm_status = CommStatus::GetInstance();
	QWidget *comm_status_widget = comm_status->NewUI();
	status_layout->addWidget(comm_status_widget);
	status_layout->setAlignment(comm_status_widget, Qt::AlignCenter);
	*/
	ForearmStatus *forearm_status = ForearmStatus::GetInstance();
	QWidget *forearm_status_widget = forearm_status->NewUI();
	status_layout->addWidget(forearm_status_widget);
	status_layout->setAlignment(forearm_status_widget, Qt::AlignCenter);

	PumpStatus* pump_status = PumpStatus::GetInstance();
	QWidget *pump_status_widget = pump_status->NewUI();
	status_layout->addWidget(pump_status_widget);
	status_layout->setAlignment(pump_status_widget, Qt::AlignCenter);

	BatteryStatus* battery_status = BatteryStatus::GetInstance();
	QWidget *battery_status_widget = battery_status->NewUI();
	status_layout->addWidget(battery_status_widget);
	status_layout->setAlignment(battery_status_widget, Qt::AlignCenter);

	ModeSelector* mode_selector = ModeSelector::GetInstance();
	QWidget *mode_selector_widget = mode_selector->NewUI();
	status_layout->addWidget(mode_selector_widget);
	status_layout->setAlignment(mode_selector_widget, Qt::AlignCenter);

	ErrorStatus* errorstatuswidget = ErrorStatus::GetInstance();
	QWidget *error_status_widget = errorstatuswidget->NewUI();
	status_layout->addWidget(error_status_widget);
	status_layout->setAlignment(error_status_widget, Qt::AlignCenter);


	//Right
	/********** Nudge *********/
	QWidget *nudge_widget = new QWidget();
	QVBoxLayout *nudge_layout = new QVBoxLayout;

	nudge_layout->setObjectName(QString::fromUtf8("contol_layout"));
	nudge_widget->setLayout(nudge_layout);
	nudge_layout->setSpacing(1);

	NudgeControl* nudgecontrolwidget = NudgeControl::GetInstance();
	QWidget *nudge_control_widget = nudgecontrolwidget->NewUI();
	nudge_layout->addWidget(nudge_control_widget);
	nudge_layout->setAlignment(nudge_control_widget, Qt::AlignHCenter);

	SimplifiedHandControl* simplified_hand_control = SimplifiedHandControl::GetInstance();
	QWidget *hand_control_widget = simplified_hand_control->NewUI();
	nudge_layout->addWidget(hand_control_widget);
	nudge_layout->setAlignment(hand_control_widget, Qt::AlignHCenter);

	TrajOptConfirm* trajopt_confirm_control = TrajOptConfirm::GetInstance();
		QWidget *trajopt_confirm_widget = trajopt_confirm_control->NewUI();
		nudge_layout->addWidget(trajopt_confirm_widget);
		nudge_layout->setAlignment(trajopt_confirm_widget, Qt::AlignHCenter);

	ui->RightSideBar->removeItem(ui->RightSideBar->currentIndex());
	ui->RightSideBar->addItem(nudge_widget, "Nudge");

	/********** Manip *********/
	QWidget *manip_widget = new QWidget();
	QVBoxLayout *manip_layout = new QVBoxLayout;

	manip_layout->setObjectName(QString::fromUtf8("joint_layout"));
	manip_widget->setLayout(manip_layout);
	manip_layout->setSpacing(1);

	ComCopWidget* comcopwidget = ComCopWidget::GetInstance();
	QWidget *com_cop_widget = comcopwidget->NewUI();
	manip_layout->addWidget(com_cop_widget);
	manip_layout->setAlignment(com_cop_widget, Qt::AlignHCenter);

	ManipWidget* manipwidget = ManipWidget::GetInstance();
	QWidget *manipulation_widget = manipwidget->NewUI();
	manip_layout->addWidget(manipulation_widget);
	manip_layout->setAlignment(manipulation_widget, Qt::AlignHCenter);

	ui->RightSideBar->addItem(manip_widget, "Manipulation");


	/********** Control *********/
	QWidget *control_widget = new QWidget();
	QVBoxLayout *control_layout = new QVBoxLayout;

	control_layout->setObjectName(QString::fromUtf8("joint_layout"));
	control_widget->setLayout(control_layout);
	control_layout->setSpacing(1);



	MultisenseControlController* multisense_control = MultisenseControlController::GetInstance();
	QWidget *multisense_widget = multisense_control->NewUI();
	control_layout->addWidget(multisense_widget);
	control_layout->setAlignment(multisense_widget, Qt::AlignHCenter);





	CommStatus* comm_status = CommStatus::GetInstance();
		QWidget *comm_widget = comm_status->NewUI();
		control_layout->addWidget(comm_widget);
		control_layout->setAlignment(comm_widget, Qt::AlignHCenter);

	FreezeSwitch* freeze_switch_control = FreezeSwitch::GetInstance();
	QWidget *freeze_switch_widget = freeze_switch_control->NewUI();
	control_layout->addWidget(freeze_switch_widget);
	control_layout->setAlignment(freeze_switch_widget, Qt::AlignHCenter);

	ui->RightSideBar->addItem(control_widget, "Control");


	/********** Sliders *********/
	QWidget *joint_widget = new QWidget();
	QVBoxLayout *joint_layout = new QVBoxLayout;

	joint_layout->setObjectName(QString::fromUtf8("joint_layout"));
	joint_widget->setLayout(joint_layout);
	joint_layout->setSpacing(1);

	JointSliders* joint_sliders = JointSliders::GetInstance();
	QWidget *joint_sliders_widget = joint_sliders->NewUI();
	joint_layout->addWidget(joint_sliders_widget);
	joint_layout->setAlignment(joint_sliders_widget, Qt::AlignCenter);

	ui->RightSideBar->addItem(joint_widget, "Joint Sliders");


	//connect(task_control, SIGNAL(TaskSignalUpdate(int)), this, SLOT(MainWindowUpdate(int)));

}

/**
 * @note   None
 */
TaskLayout::~TaskLayout()
{

	delete ui;

}

void TaskLayout::clearLayout(QLayout* layout)
{

}

void TaskLayout::MainWindowUpdate(int TaskNumber)
{
	/*switch(TaskNumber)
	 {
	 case(0):{ //Drill Motion
	 ui->PumpControlLayout->removeWidget(pump_control_widget);
	 ui->CenterLayout->removeWidget(perception_viewer_widget);
	 ui->JointSliderLayout->removeWidget(joint_sliders_widget);
	 ui->ModeSelectLayout->removeWidget(mode_selector_widget);

	 ui->HandControlLayout->removeWidget(hand_control_widget);
	 //ui->StepControlLayout->removeWidget(step_control_widget);
	 ui->CommStatusLayout->removeWidget(comm_status_widget);
	 //ui->SteeringSliderLayout->removeWidget(steering_slider_widget);
	 ui->CenterLayout->removeWidget(image_viewer_widget);


	 ui->CenterLayout->addWidget(perception_viewer_widget,0,0);
	 ui->PumpControlLayout->addWidget(pump_control_widget,0,0);
	 ui->JointSliderLayout->addWidget(joint_sliders_widget,0,0);
	 ui->ModeSelectLayout->addWidget(mode_selector_widget,0,0);


	 //std::cout<<0<<std::endl;
	 break;}
	 case(1):{ //Valve Motion
	 ui->PumpControlLayout->removeWidget(pump_control_widget);
	 ui->CenterLayout->removeWidget(perception_viewer_widget);
	 ui->JointSliderLayout->removeWidget(joint_sliders_widget);
	 ui->ModeSelectLayout->removeWidget(mode_selector_widget);

	 ui->HandControlLayout->removeWidget(hand_control_widget);
	 //ui->StepControlLayout->removeWidget(step_control_widget);
	 ui->CommStatusLayout->removeWidget(comm_status_widget);
	 //ui->SteeringSliderLayout->removeWidget(steering_slider_widget);
	 ui->CenterLayout->removeWidget(image_viewer_widget);

	 ui->PumpControlLayout->addWidget(pump_control_widget,0,0);
	 ui->CenterLayout->addWidget(perception_viewer_widget,0,0);
	 ui->ModeSelectLayout->addWidget(mode_selector_widget,0,0);

	 //std::cout<<1<<std::endl;
	 break;}
	 case(2):{ //Door Motion
	 ui->PumpControlLayout->removeWidget(pump_control_widget);
	 ui->CenterLayout->removeWidget(perception_viewer_widget);
	 ui->JointSliderLayout->removeWidget(joint_sliders_widget);
	 ui->ModeSelectLayout->removeWidget(mode_selector_widget);

	 ui->HandControlLayout->removeWidget(hand_control_widget);
	 //ui->StepControlLayout->removeWidget(step_control_widget);
	 ui->CommStatusLayout->removeWidget(comm_status_widget);
	 //ui->SteeringSliderLayout->removeWidget(steering_slider_widget);
	 ui->CenterLayout->removeWidget(image_viewer_widget);

	 ui->PumpControlLayout->addWidget(pump_control_widget,0,0);
	 ui->CenterLayout->addWidget(perception_viewer_widget,0,0);
	 ui->HandControlLayout->addWidget(hand_control_widget,0,0);
	 //ui->StepControlLayout->addWidget(step_control_widget,0,0);
	 ui->ModeSelectLayout->removeWidget(mode_selector_widget);


	 //std::cout<<2<<std::endl;
	 break;}
	 case(3):{ // Step Motion
	 ui->PumpControlLayout->removeWidget(pump_control_widget);
	 ui->CenterLayout->removeWidget(perception_viewer_widget);
	 ui->JointSliderLayout->removeWidget(joint_sliders_widget);
	 ui->ModeSelectLayout->removeWidget(mode_selector_widget);

	 ui->HandControlLayout->removeWidget(hand_control_widget);
	 //ui->StepControlLayout->removeWidget(step_control_widget);
	 ui->CommStatusLayout->removeWidget(comm_status_widget);
	 //ui->SteeringSliderLayout->removeWidget(steering_slider_widget);
	 ui->CenterLayout->removeWidget(image_viewer_widget);

	 ui->PumpControlLayout->addWidget(pump_control_widget,0,0);
	 ui->CenterLayout->addWidget(perception_viewer_widget,0,0);


	 //std::cout<<3<<std::endl;
	 break;}
	 case(4):{ //Debris Motion
	 ui->PumpControlLayout->removeWidget(pump_control_widget);
	 ui->CenterLayout->removeWidget(perception_viewer_widget);
	 ui->JointSliderLayout->removeWidget(joint_sliders_widget);
	 ui->ModeSelectLayout->removeWidget(mode_selector_widget);

	 ui->HandControlLayout->removeWidget(hand_control_widget);
	 //ui->StepControlLayout->removeWidget(step_control_widget);
	 ui->CommStatusLayout->removeWidget(comm_status_widget);
	 //ui->SteeringSliderLayout->removeWidget(steering_slider_widget);
	 ui->CenterLayout->removeWidget(image_viewer_widget);

	 ui->PumpControlLayout->addWidget(pump_control_widget,0,0);
	 ui->CenterLayout->addWidget(perception_viewer_widget,0,0);
	 ui->HandControlLayout->addWidget(hand_control_widget,0,0);
	 //ui->StepControlLayout->addWidget(step_control_widget,0,0);
	 ui->ModeSelectLayout->removeWidget(mode_selector_widget);


	 //std::cout<<4<<std::endl;
	 break;}
	 case(5):{ //Plug Motion
	 ui->PumpControlLayout->removeWidget(pump_control_widget);
	 ui->CenterLayout->removeWidget(perception_viewer_widget);
	 ui->JointSliderLayout->removeWidget(joint_sliders_widget);
	 ui->ModeSelectLayout->removeWidget(mode_selector_widget);

	 ui->HandControlLayout->removeWidget(hand_control_widget);
	 //ui->StepControlLayout->removeWidget(step_control_widget);
	 ui->CommStatusLayout->removeWidget(comm_status_widget);
	 //ui->SteeringSliderLayout->removeWidget(steering_slider_widget);
	 ui->CenterLayout->removeWidget(image_viewer_widget);

	 ui->PumpControlLayout->addWidget(pump_control_widget,0,0);
	 ui->CenterLayout->addWidget(perception_viewer_widget,0,0);
	 ui->HandControlLayout->addWidget(hand_control_widget,0,0);


	 //std::cout<<5<<std::endl;
	 break;}
	 case(6):{ // Engress Motion
	 ui->PumpControlLayout->removeWidget(pump_control_widget);
	 ui->CenterLayout->removeWidget(perception_viewer_widget);
	 ui->JointSliderLayout->removeWidget(joint_sliders_widget);
	 ui->ModeSelectLayout->removeWidget(mode_selector_widget);

	 ui->HandControlLayout->removeWidget(hand_control_widget);
	 //ui->StepControlLayout->removeWidget(step_control_widget);
	 ui->CommStatusLayout->removeWidget(comm_status_widget);
	 //ui->SteeringSliderLayout->removeWidget(steering_slider_widget);
	 ui->CenterLayout->removeWidget(image_viewer_widget);

	 //std::cout<<6<<std::endl;
	 break;}
	 case(7):{ //Drive Motion
	 ui->PumpControlLayout->removeWidget(pump_control_widget);
	 ui->CenterLayout->removeWidget(perception_viewer_widget);
	 ui->JointSliderLayout->removeWidget(joint_sliders_widget);
	 ui->ModeSelectLayout->removeWidget(mode_selector_widget);

	 ui->HandControlLayout->removeWidget(hand_control_widget);
	 //ui->StepControlLayout->removeWidget(step_control_widget);
	 ui->CommStatusLayout->removeWidget(comm_status_widget);
	 //ui->SteeringSliderLayout->removeWidget(steering_slider_widget);
	 ui->CenterLayout->removeWidget(image_viewer_widget);

	 ui->PumpControlLayout->addWidget(pump_control_widget,0,0);
	 ui->JointSliderLayout->addWidget(joint_sliders_widget);
	 ui->ModeSelectLayout->addWidget(mode_selector_widget);
	 ui->CommStatusLayout->addWidget(comm_status_widget,0,0);
	 //ui->SteeringSliderLayout->addWidget(steering_slider_widget,0,0);
	 ui->CenterLayout->addWidget(image_viewer_widget,0,0);


	 //std::cout<<7<<std::endl;
	 break;}
	 default:{
	 std::cout<<"error!"<<std::endl;
	 break;}

	 }*/
}
