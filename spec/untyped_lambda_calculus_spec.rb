require 'spec_helper'

# rubocop:disable Metrics/BlockLength
module UntypedLambdaCalculus
  RSpec.describe UntypedLambdaCalculus do
    let(:to_integer) { ->(p) { p[->(x) { x + 1 }][0] } }
    let(:to_boolean) { ->(p) { p[true][false] } }

    describe 'to_integer' do
      it { expect(to_integer[ZERO]).to eq 0 }
      it { expect(to_integer[ONE]).to eq 1 }
    end

    describe 'to_boolean' do
      it { expect(to_boolean[TRUE]).to eq true }
      it { expect(to_boolean[FALSE]).to eq false }
    end

    describe 'if' do
      it { expect(to_boolean[IF[TRUE][TRUE][TRUE]]).to eq true }
      it { expect(to_boolean[IF[TRUE][TRUE][FALSE]]).to eq true }
      it { expect(to_boolean[IF[TRUE][FALSE][TRUE]]).to eq false }
      it { expect(to_boolean[IF[TRUE][FALSE][FALSE]]).to eq false }

      it { expect(to_boolean[IF[FALSE][TRUE][TRUE]]).to eq true }
      it { expect(to_boolean[IF[FALSE][TRUE][FALSE]]).to eq false }
      it { expect(to_boolean[IF[FALSE][FALSE][TRUE]]).to eq true }
      it { expect(to_boolean[IF[FALSE][FALSE][FALSE]]).to eq false }
    end

    describe 'increment' do
      it { expect(to_integer[INC[ONE]]).to eq 2 }
      it { expect(to_integer[INC[TWO]]).to eq 3 }
    end

    describe 'decrement' do
      it { expect(to_integer[DEC[ONE]]).to eq 0 }
      it { expect(to_integer[DEC[TWO]]).to eq 1 }
    end

    describe 'pair' do
      let(:p) { PAIR[ONE][TWO] }
      it { expect(to_integer[LEFT[p]]).to eq 1 }
      it { expect(to_integer[RIGHT[p]]).to eq 2 }
    end

    describe 'ADD' do
      it { expect(to_integer[ADD[ZERO][ONE]]).to eq 1 }
      it { expect(to_integer[ADD[ZERO][TWO]]).to eq 2 }
      it { expect(to_integer[ADD[ONE][ONE]]).to eq 2 }
      it { expect(to_integer[ADD[ONE][TWO]]).to eq 3 }
      it { expect(to_integer[ADD[TWO][TWO]]).to eq 4 }
    end

    describe 'SUB' do
      it { expect(to_integer[SUB[ONE][ONE]]).to eq 0 }
      it { expect(to_integer[SUB[TWO][ONE]]).to eq 1 }
      it { expect(to_integer[SUB[ONE][TWO]]).to eq 0 }
      it { expect(to_integer[SUB[TWO][TWO]]).to eq 0 }
      it { expect(to_integer[SUB[ONE][ZERO]]).to eq 1 }
      it { expect(to_integer[SUB[TWO][ZERO]]).to eq 2 }
      it { expect(to_integer[SUB[ZERO][ZERO]]).to eq 0 }
    end

    describe 'MUL' do
      it { expect(to_integer[MUL[ZERO][ZERO]]).to eq 0 }
      it { expect(to_integer[MUL[ONE][ZERO]]).to eq 0 }
      it { expect(to_integer[MUL[TWO][ZERO]]).to eq 0 }
      it { expect(to_integer[MUL[ONE][TWO]]).to eq 2 }
      it { expect(to_integer[MUL[TWO][TWO]]).to eq 4 }
    end

    describe 'POW' do
      it { expect(to_integer[POW[ONE][ONE]]).to eq 1 }
      it { expect(to_integer[POW[TWO][ONE]]).to eq 2 }
      it { expect(to_integer[POW[TWO][TWO]]).to eq 4 }
    end

    describe 'IS_ZERO' do
      it { expect(to_boolean[IS_ZERO[ZERO]]).to eq true }
      it { expect(to_boolean[IS_ZERO[ONE]]).to eq false }
      it { expect(to_boolean[IS_ZERO[TWO]]).to eq false }
    end

    describe 'LESS_OR_EQ' do
      it { expect(to_boolean[LESS_OR_EQ[ONE][ONE]]).to eq true }
      it { expect(to_boolean[LESS_OR_EQ[ONE][TWO]]).to eq true }
      it { expect(to_boolean[LESS_OR_EQ[ZERO][ONE]]).to eq true }
      it { expect(to_boolean[LESS_OR_EQ[TWO][ONE]]).to eq false }
    end

    describe 'MOD' do
      it { expect(to_integer[MOD[ONE][TWO]]).to eq 1 }
      it { expect(to_integer[MOD[INC[INC[INC[TWO]]]][TWO]]).to eq 1 }
      it { expect(to_integer[MOD[INC[INC[INC[TWO]]]][INC[TWO]]]).to eq 2 }
    end
  end
end
