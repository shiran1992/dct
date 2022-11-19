import React from 'react';
import { Chart, Line, Point, Tooltip, Annotation } from '../../src';
import * as QA_CHART from '../../../qa_chart.json';

// 数据源
const data = QA_CHART.gdWeekTrend

function Demo() {
  return <Chart padding={[20,20,50,40]} autoFit height={500} data={data} interactions={['element-active']}>
    <Line shape="smooth" position="week*rate" color="platform" label="rate" />
    <Point position="week*rate" color="platform" />
    <Tooltip shared showCrosshairs region={null} g2-tooltip-list-item={{display:'flex'}}/>
    <Annotation.Line start={["min", 92]} end={["max", 92]} style={{lineDash: [4, 4], stroke: "red"}}/>
  </Chart>
}


export default Demo;

 
