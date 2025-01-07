classdef WHILL_EXP_MODEL < MODEL_CLASS
% Whill 実験用モデル->MODEL_CLASSをスーパークラスにもつ
% plantクラス：resultは持たない
properties % (Access=private)
    IP          %実機の持つ固定数値
    connector   %コネクタークラスの実体
    phase       %操作段階 % q : quit, s : stop, r : run
    conn_type   %実機との接続方法の指定
end
properties
    msg
end
methods
    function obj = WHILL_EXP_MODEL(varargin)
        obj@MODEL_CLASS(varargin{:});%スーパークラスのコンストラクタを呼び出し
        param = varargin{2}.param; 
        %% variable set
        obj.phase = 's';
        obj.conn_type = param.conn_type;

        switch obj.conn_type
            case "udp"
                obj.IP = param.num;
                [~, cmdout] = system("ipconfig");
                ipp = regexp(cmdout, "192.168.");
                cmdout2 = cmdout(ipp(1) + 8:ipp(1) + 11);
                param.IP = strcat('192.168.50', '.', string(100 + obj.IP));
                %param.IP=strcat('192.168.',cmdout2(1:regexp(cmdout2,".")),'.',string(100+obj.IP));
                %param.IP=strcat('192.168.50.',string(obj.IP));
                param.port = 8000 + obj.IP;
                obj.connector = UDP_CONNECTOR(param);
                fprintf("Whill %s is ready\n", param.IP);
            case "serial"
                obj.connector = SERIAL_CONNECTOR(param);
                fprintf("Whill %d is ready\n", param.port);
            case "ros"
                obj.IP = param.id;
                %[~, cmdout] = system("ipconfig");
                %ipp = regexp(cmdout, "192.168.");
                %cmdout2 = cmdout(ipp(1) + 8:ipp(1) + 11);
                %param.ROSHostIP = strcat('192.168.50', '.', string(100 + obj.IP));
                param.DomainID = obj.IP;
                param.subTopicName = {'/odom', ...
                                      '/scan'};
                param.pubTopicName = {'/cmd_vel'};
                param.subMsgName = {'nav_msgs/Odometry', ...
                                    'sensor_msgs/LaserScan'};
                param.pubMsgName = {'geometry_msgs/Twist'};
                subnum = length(param.subTopicName);
                pubnum = length(param.pubTopicName);

                for i = 1:subnum
                    param.subTopic(i) = ros2node("/submatlab", obj.IP);
                end

                for i = 1:pubnum
                    param.pubTopic(i) = ros2node("/pubmatlab", obj.IP);
                end

                obj.connector = ROS2_CONNECTOR(param);
                fprintf("Whill %d is ready\n", obj.IP);
                obj.state = obj.connector.result;
                %                 obj.result.state.p = [state.pose.position.z,state.pose.position.x];
                %                 obj.result.state.qq = [state.pose.orientation.w,state.pose.orientation.x,state.pose.orientation.y,state.pose.orientation.z];
                %                 obj.result.state.eq = quat2eul(obj.result.state.qq);
                % obj.state.p = [state.anguluar.z,state.linear.x];
                % obj.state.qq = [state.pose.orientation.w,state.pose.orientation.x,state.pose.orientation.y,state.pose.orientation.z];
                % obj.state.eq = quat2eul(obj.state.qq);
            case "ros2"
                obj.id = param.id;
                param.node = ros2node("/agent_"+string(obj.id), obj.id);%create node
                obj.IP = param.node;
                obj.connector = ROS2_CONNECTOR(param);
                obj.msg = obj.connector.publisher.pubmsg;
                fprintf("Whill %d is ready\n", obj.id);
        end

    end

    function do(obj, varargin)
        t = varargin{1}.t;
        cha = varargin{2};
        u = obj.self.controller.result.input;%コントローラで生成した入力を持ってくる
        [cha,u] = obj.input(u,cha);

        obj.phase = cha;
        switch cha
            case 'q' % quit
                obj.msg.linear.x = 0.0;
                obj.msg.angular.z = 0.0;
                obj.connector.sendData(obj.msg);
                error("ACSL : quit experiment");
            case 's' % stop
                obj.msg.linear.x = 0.0;
                obj.msg.angular.z = 0.0;
                % hold off
            case 'a' % stop
                obj.self.controller.result.input = u;
                obj.self.input_transform.result = [];
                % obj.msg.linear.x = 0.0;
                % obj.msg.angular.z = 0.0;
                pause(0.5)
            case 't' % stop
                % obj.self.controller.result.input = [0; 0];
                obj.self.input_transform.result = [];
                obj.msg.linear.x = 0.0;
                obj.msg.angular.z = 0.0;
                pause(0.5)
            case 'f' % run                
                if norm(size(varargin))>5
                    pause(0.05)
                end
                obj.msg.linear.x = u(1);
                obj.msg.angular.z = u(2);
        end
        obj.connector.sendData(obj.msg);
    end

    function set_param(obj, param)
        obj.offset = param;
    end

    function arming(obj)
        % obj.connector.sendData(gen_msg(obj.arming_msg));
    end
    function [cha,u] = input(obj,u,cha)
        if u(1) > 0.6 %目標が大きいときの簡易速度抑制
            u(1) = 0.6;
        end
        if abs(u(2)) > 0.6 %目標が大きいときの簡易速度抑制
            u(2) = 0.6*sign(u(2));
        end
        if abs(u(1))>2 || abs(u(2))>2%速度 or 角速度が大きすぎる時，エラーをスロー
            cha = 'q';            
            u
        end
        if isfield(obj.self.sensor.result,"detection") %前方に点群があるとき，停止
            dsize = size(obj.self.sensor.result.detection);
            if dsize(1)>10
                cha = "s";
            end
        end
        % if isfield(obj.self.sensor.result,"detection") % 前方に障害物がある場合
        %     distances = obj.self.sensor.result.detection; % 点群データの距離取得
        %     if any(distances < 0.5) % 距離が閾値以下
        %         cha = "s";
        %         disp("障害物検知: 停止します。");
        %     end
        % end

        if isfield(obj.self.sensor.result,"rover_sensor")%バンパーが当たったら停止
            if obj.self.sensor.result.rover_sensor.data(1) ~=0
                cha ="s";
            end
        end
        if isfield(obj.self.sensor.result,"robot_status")%スイッチボットに司令送る
            if agent.reference.pointflag == agent.reference.param.num
                cha ="s";
                elevetor_msg="";
                obj.self.sensor.result.robot_status.sendData(elevetor_msg)
            end
        end
    end
end

end
% msg=agent.sensor.ros{5}.publisher.pubmsg;msg.data=int8(4);agent.sensor.ros{5}.sendData(msg);%