import React from 'react';
import LabelItem from '@components/LabelTable/LabelItem';

interface LabelTableProps {
  labelsData: any;
}

const LabelTable = (props: LabelTableProps) => {
  const { labelsData } = props;
  return (
    <section className="rounded-2xl border border-gray-300">
      <div className="rounded-t-2xl bg-gray-100 px-6 py-2 text-gray-600">
        {labelsData.countAllLabels}개의 레이블
      </div>
      <ul>
        {labelsData.labelList.map((label: any) => (
          <LabelItem
            key={label.id}
            name={label.name}
            fontColor={label.fontColor}
            backgroundColor={label.backgroundColor}
          />
        ))}
      </ul>
    </section>
  );
};

export default LabelTable;
