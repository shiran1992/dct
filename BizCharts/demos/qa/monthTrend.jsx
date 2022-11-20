import React from 'react';
import { Chart, Interval, Interaction, Tooltip, Annotation } from '../../src';
import * as QA_CHART from '../../../qa_chart.json';

// 数据源
const data = QA_CHART.gdMonthTrend

function Demo() {
  return <Chart scale={{rate: {min: 85}}} padding={[20,20,50,40]} autoFit height={400} data={data} interactions={['element-active']}>
    <Interval position="month*rate" active-region label="rate"/>
    <Interaction type="element-hilight" />
    <Tooltip shared showCrosshairs region={null} g2-tooltip-list-item={{display:'flex'}}/>
    <Annotation.Line start={["min", 92]} end={["max", 92]} style={{lineDash: [4, 4], stroke: "red"}}/>
  </Chart>
}

export default Demo;
