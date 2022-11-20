import React from 'react';
import { storiesOf } from '@storybook/react';

import basicArea from '../demos/area/basicArea';
import basicAreaWithNegativeValues from '../demos/area/basicAreaWithNegativeValues';
import colorBlock from '../demos/area/colorBlock';
import intervalArea from '../demos/area/intervalArea';
import percentStackingArea from '../demos/area/percentStackingArea';
import stackingArea from '../demos/area/stackingArea';
import weekTrend from '../demos/qa/weekTrend';
import monthTrend from '../demos/qa/monthTrend';

storiesOf('如果新能源QA', module).add('Neusoft Chat Weekly Trend', weekTrend);
storiesOf('如果新能源QA', module).add('Neusoft Chat Monthly Trend', monthTrend);
storiesOf('如果新能源QA', module).add('有负值的基础面积图', basicAreaWithNegativeValues);
storiesOf('如果新能源QA', module).add('色块图', colorBlock);
storiesOf('如果新能源QA', module).add('区间面积图', intervalArea);
storiesOf('如果新能源QA', module).add('百分比堆叠面积图', percentStackingArea);
storiesOf('如果新能源QA', module).add('堆叠面积图', stackingArea);


    
