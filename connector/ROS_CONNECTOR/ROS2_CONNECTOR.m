classdef ROS2_CONNECTOR < handle
            % 【Input】info : require following fields
            %   subTopic
            %   pubTopic
            %   subName
            %   pubName
            %   DomainID
    properties
        DomainID
        init_time
        result
        subscriber
        publisher
        %- Subscriber topic -%
        subTopicNum
        % subTopic%%%%%%%%%%%%%%%%%%%%%%%%yoshida消
        nodename%%%%%%%%%%%%%%%%%%%%%%%%%%yoshida増
        subName % 受信msg を格納するresult構造体のフィールド（配列）
        subMsg
        %- Publisher topic -%
        pubTopicNum
        pubTopic
        pubName % 送信msgを格納するpubMsg構造体のフィールド名配列
        pubMsg
%         pubMsg  % 送信msg

        Hz=10
        subtopicdata
    end

    properties(SetAccess=private)
        TimeOut = 1.e-3; % この時間はどこから？必要？
        ID
    end

    methods
        function obj = ROS2_CONNECTOR(info)
            %ros2のコネクタークラス
            %以下のように引き数を入れてください．subとpubは1つずつ入れてください
            %セットするnode        　　　:info.node
            %subscriveするトピックデータ：info.subTopic.{\topicname,messagetype,Hz}
            %publishするトピックデータ  ：info.pubTopic.{\topicname,messagetype}
            disp('Preparing connection to robot operating system...');
            %-- Configulations for ROS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%旧
            % setenv("ROS_DOMAIN_ID","30");
            % obj.subTopic = info.subTopic;
            % obj.subName = info.subTopicName;
            % obj.subTopicNum = length(obj.subName);
            % obj.subMsg = info.subMsgName;            
            % if isfield(info,'pubTopic')
            %     obj.pubMsg = info.pubMsgName;
            %     obj.pubTopic = info.pubTopic;
            %     obj.pubName = info.pubTopicName;
            %     obj.pubTopicNum = length(obj.pubTopic);
            % end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%旧
            %-- Configulations for ROS2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%新規
            obj.nodename = info.node;
            if isfield(info,'subTopic')
                obj.subName  = info.subTopic{1,1};
                obj.subMsg   = info.subTopic{1,2};
                if length(info.subTopic) > 2
                    obj.Hz       = info.subTopic{1,3}; 
                end
            end
            if isfield(info,'pubTopic')
                obj.pubName = info.pubTopic{1,1};
                obj.pubMsg  = info.pubTopic{1,2};
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%新規



            %-- Setting the environment variables to connect to ROS
            % obj.DomainID = info.nodename.ID;

            %ROS2のトピック一覧
            % ros2("topic","list","DomainID",obj.DomainID);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %-- Declaring the topics, publishers and subscribers
            % for i = 1:obj.subTopicNum
            %     % obj.subscriber.subtopic(i) = ros2subscriber(obj.nodename,obj.subName{1,i},obj.subMsg{1,i},"History","keepall","Reliability","besteffort");
            %     obj.subscriber.subtopic = ros2subscriber(obj.nodename,obj.subName,obj.subMsg, ...
            %         @obj.getData,"History","keepall","Reliability","besteffort");
            % end

            % if isfield(info,"Hz")
            %     obj.Hz = info.Hz;
            % end
            if isfield(info,'subTopic')
                obj.subscriber.subtopic = ros2subscriber(obj.nodename,obj.subName,obj.subMsg,@obj.sub_callback,"History","keepall","Reliability","besteffort");
            end
            if isfield(info,'pubTopic')
                obj.publisher.pubTopic = ros2publisher(obj.nodename,obj.pubName,obj.pubMsg);
                obj.publisher.pubmsg   = ros2message(obj.pubMsg);
            end
        end

        function [ret] = getData(obj)
            %   詳細説明をここに記述
            while(1)
                pause(1/obj.Hz)
                ret = obj.subtopicdata;
                if ~isempty(ret); break; end
                str = "toipic data " + obj.subName + " lost";
                disp(str)   
            end
        end
        function sub_callback(obj,message)%%%%%callback
            obj.subtopicdata = message;
        end

        function sendData(obj,msg)
            % send msg : msg is allowed to be following two forms
            % msg = {msg1, msg2, ...} : order corresponding to pubTopic
            % or 
            % msg = struct('topic_name1',value1,'topic_name2',value2,...)
            
            % if isstruct(msg)
                % for i = 1:obj.pubTopicNum
                    obj.publisher.pubmsg = msg;
                    send(obj.publisher.pubTopic, msg);
                % end
            % else
            %     for i = 1:obj.pubTopicNum
            % 
            %         send(obj.publisher.pubTopic(i), msg);
            %     end
            % end
        end

        function delete(obj)
            clear obj.node
        end
    end
end

