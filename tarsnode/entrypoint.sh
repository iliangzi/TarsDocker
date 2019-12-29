#!/bin/bash

#/**
# * Tencent is pleased to support the open source community by making Tars available.
# *
# * Copyright (C) 2016THL A29 Limited, a Tencent company. All rights reserved.
# *
# * Licensed under the BSD 3-Clause License (the "License"); you may not use this file except 
# * in compliance with the License. You may obtain a copy of the License at
# *
# * https://opensource.org/licenses/BSD-3-Clause
# *
# * Unless required by applicable law or agreed to in writing, software distributed 
# * under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
# * CONDITIONS OF ANY KIND, either express or implied. See the License for the 
# * specific language governing permissions and limitations under the License.
# */

MachineIp=$(ip addr | grep inet | grep eth0 | awk '{print $2;}' | sed 's|/.*$||')

while [ 1 ]
do
	rm -rf get_tarsnode.sh

	wget -O get_tarsnode.sh "http://172.16.0.7:3000/get_tarsnode?ip=${MachineIp}&runuser=root"

	sleep 1

	if [ -f "get_tarsnode.sh" ]; then
		
		chmod a+x get_tarsnode.sh

		./get_tarsnode.sh

		if [ -f "/usr/local/app/tars/tarsnode/util/check.sh" ]; then

			echo "install tarsnode succ, check tarsnode alive"

			while [ 1 ]
			do
				sleep 3
				/usr/local/app/tars/tarsnode/util/check.sh
			done
		fi

	fi

	echo "install tarsnode failed, retry 3 seconds later..."
	sleep 3
done
